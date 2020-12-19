//
//  CoreDataManager.swift
//  FoodicsAssesment
//
//  Created by mohamed gamal on 12/19/20.
//

import Foundation
import Promises
import CoreData

class CoreDataStackManager: DataBaseManagerProtocol {
    // MARK: - Core Data stack
    let containerName: String
    let persistentContainer: NSPersistentContainer
    var viewContext: NSManagedObjectContext!
    var backgroundContext: NSManagedObjectContext!

    init(containerName: String) {
        self.containerName = containerName
        guard let modelURL = Bundle(for: type(of: self)).url(forResource: containerName, withExtension: "momd") else {
            fatalError("Error loading model from bundle")
        }

        guard let mom = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Error initializing mom from: \(modelURL)")
        }

        persistentContainer = NSPersistentContainer(name: containerName, managedObjectModel: mom)
        start()
    }

    let group = DispatchGroup()
    @discardableResult
    func start() -> Promise<Void> {
        group.enter()
        let promise = Promise<Void>.pending()
        self.persistentContainer.loadPersistentStores { [weak self] ( _, error) in
            if let error = error {
                promise.reject(error)
                fatalError("Failed to load Core Data stack: \(error)")
            }
            self?.configureContexts()
            self?.configContainer()
            self?.group.leave()
            promise.fulfill(Void())
        }
        return promise
    }

    /// Handles migration incase of a future change in any of the entities in the database
    fileprivate func configContainer() {
        let description = NSPersistentStoreDescription()
        description.shouldMigrateStoreAutomatically = true
        description.shouldInferMappingModelAutomatically = true
        persistentContainer.persistentStoreDescriptions = [description]
    }

    fileprivate func configureContexts() {
        backgroundContext = persistentContainer.newBackgroundContext()
        viewContext = persistentContainer.viewContext
        viewContext.automaticallyMergesChangesFromParent = true
        backgroundContext.automaticallyMergesChangesFromParent = true
        backgroundContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        viewContext.mergePolicy = NSMergePolicy.mergeByPropertyStoreTrump
    }

    func fetch<Output, Query>(query: Query, outputType: Output.Type) -> Promise<[Output]> {
        group.wait()
        return retry(on: .promises, attempts: 9, delay: 2, condition: { (_, error) -> Bool in
            return (error as NSError).code  == 10
        }, { () -> Promise<[Output]> in
            if self.backgroundContext == nil {
                return Promise<[Output]>(NSError.init(domain: "", code: 10, userInfo: nil))
            }
            guard let query  = query as? NSFetchRequest<NSFetchRequestResult> else {
                fatalError("CoreDataStackManager Only fetch quaries of type NSFetchRequest")
            }
            do {
                let fetchedData =  try self.backgroundContext.fetch(query)
                if let output =  fetchedData as? [Output] {
                    return Promise<[Output]>(output)
                } else {
                    fatalError("un expected output type")
                }
            } catch {
                return Promise<[Output]>(error)
            }
        })
    }

    // avoid deadlocks by not using .main queue here

    func insert<Input>(data: Input) -> Promise<Void> {
        let result = Promise<Void>.pending()
        group.wait()
        var inputs = [NSManagedObject]()
        if let data = data as? [NSManagedObject] {
            inputs = data
        } else if let data = data as? NSManagedObject {
            inputs.append( data)
        } else {
            fatalError("Data must be child of NSManagedObject")
        }
        backgroundContext.performAndWait { [weak self] in
            inputs.forEach { (data) in
                self?.backgroundContext.insert(data)
            }
            if  backgroundContext.hasChanges {
                do {
                    try backgroundContext.save()
                    result.fulfill(Void())
                } catch {
                    result.reject(error)
                }
            }
        }
        return result
    }

    func clear() -> Promise<Void> {
        // this is a hacky implemetation just for ruuning well
        // Not implemented
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = CategoryEntity.fetchRequest()
        fetchRequest.returnsObjectsAsFaults = false

        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try backgroundContext.execute(deleteRequest)
        } catch let error as NSError {
            return Promise<Void>(error)
        }
        return Promise<Void>.init { }
    }

    func save() -> Promise<Void> {
        let result = Promise<Void>.pending()
        if  backgroundContext.hasChanges {
            do {
                try backgroundContext.save()
                result.fulfill(Void())
            } catch {
                result.reject(error)
            }
        }
        return result
    }

}
