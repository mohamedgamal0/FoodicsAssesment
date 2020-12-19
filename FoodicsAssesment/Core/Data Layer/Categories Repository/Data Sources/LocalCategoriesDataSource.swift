//
//  LocalCategoriesDataSource.swift
//  FoodicsAssesment
//
//  Created by mohamed gamal on 12/19/20.
//

import Foundation
import Promises
import CoreData

protocol CategoriesDataSource: class {
    func fetch(pageSize: Int, pageNumber: Int) -> Promise<[CategoryModel]>
    func fetchAll() -> Promise<[CategoryModel]>
    @discardableResult func save( _ stock: CategoryModel) -> Promise<Void>
    @discardableResult func save( _ stocks: [CategoryModel]) -> Promise<Void>
    @discardableResult func distroy() -> Promise<Void>
}


class LocalCategoriesDataSource: CategoriesDataSource {

    @Injected private var dataBaseManager: DataBaseManagerProtocol

    func fetch(pageSize: Int, pageNumber: Int) -> Promise<[CategoryModel]> {
        let fetchRequest: NSFetchRequest<CategoryEntity> = CategoryEntity.fetchRequest()
        fetchRequest.fetchOffset = pageSize * (pageNumber - 1)
        fetchRequest.fetchLimit = pageSize
        return dataBaseManager
            .fetch(query: fetchRequest, outputType: CategoryEntity.self)
            .then { (categories) -> Promise<[CategoryModel]> in
                if categories.count == 0 {
                    return  Promise(NSError.notFound)
                }
                return Promise(categories.map({$0.toCategoryModel()}))
            }
    }

    func fetchAll() -> Promise<[CategoryModel]>{
        return Promise(NSError(domain: "fetchAllNotAllowed", code: 500, userInfo: nil))
    }

    @discardableResult func save( _ stock: CategoryModel) -> Promise<Void> {
        let entity  = stock.toCategoryEntity()
        return dataBaseManager.insert(data: entity)
    }

    @discardableResult func save( _ stocks: [CategoryModel]) -> Promise<Void> {
        let entities  = stocks.map({$0.toCategoryEntity()})
        return dataBaseManager.insert(data: entities)
    }

    @discardableResult func distroy() -> Promise<Void> {
        self.dataBaseManager.clear()
    }
}
