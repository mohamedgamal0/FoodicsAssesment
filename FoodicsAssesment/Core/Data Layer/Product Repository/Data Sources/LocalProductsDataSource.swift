//
//  LocalProductsDataSource.swift
//  FoodicsAssesment
//
//  Created by mohamed gamal on 12/19/20.
//

import Foundation
import Promises
import CoreData

protocol ProductsDataSource: class {
    func fetch(categoryId:String,
               pageSize: Int,
               pageNumber: Int) -> Promise<[ProductModel]>
    func fetchAll() -> Promise<[ProductModel]>
    @discardableResult func save( categoryId:String, stocks: [ProductModel]) -> Promise<Void>
    @discardableResult func distroy() -> Promise<Void>
}


class LocalProductsDataSource: ProductsDataSource {

    @Injected private var dataBaseManager: DataBaseManagerProtocol

    func fetch(categoryId:String,
               pageSize: Int,
               pageNumber: Int) -> Promise<[ProductModel]> {

        let fetchRequest: NSFetchRequest<ProductEntity> = ProductEntity.fetchRequest()
        let predicate = NSPredicate(format: "categoryId = %@", categoryId)
        fetchRequest.predicate = predicate
        fetchRequest.fetchOffset = pageSize * (pageNumber - 1)
        fetchRequest.fetchLimit = pageSize
        return dataBaseManager
            .fetch(query: fetchRequest, outputType: ProductEntity.self)
            .then { (products) -> Promise<[ProductModel]> in
                if  products.count != 0 {
                    return Promise(products.map({$0.toProductModel()}))
                }
                return  Promise(NSError.notFound)
            }
    }

    func fetchAll() -> Promise<[ProductModel]>{
        return Promise(NSError(domain: "fetchAllNotAllowed", code: 500, userInfo: nil))
    }

    @discardableResult func save( categoryId:String, stocks: [ProductModel]) -> Promise<Void> {
        let products = stocks.map({$0.toProductEntity(categoryId: categoryId)})
        return dataBaseManager.insert(data: products)
    }

    @discardableResult func distroy() -> Promise<Void> {
        self.dataBaseManager.clear()
    }
}
