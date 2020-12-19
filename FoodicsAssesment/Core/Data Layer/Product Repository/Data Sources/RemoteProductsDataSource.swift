//
//  RemoteProductsDataSource.swift
//  FoodicsAssesment
//
//  Created by mohamed gamal on 12/19/20.
//

import Foundation
import Promises

class RemoteProductsDataSource: ProductsDataSource {

    @Injected private var network: NetworkManagerProtocol
    @Injected private var provider: APIRequestProviderProtocol

    func fetch(categoryId: String, pageSize: Int, pageNumber: Int) -> Promise<[ProductModel]> {
        let promise = Promise<[ProductModel]>.pending()
        let getProductsRequest = GetProductsApiRequest(categoryId: categoryId,
                                                       pageSize: pageSize,
                                                       pageNumber: pageNumber)
        network.perform(apiRequest: getProductsRequest,
                        providerType: self.provider,
                        outputType: BaseResponse<[ProductAPIModel]>.self)
            .then({ (response)  in
                let products = response.data?.map({$0.toProductModel()}) ?? []
                promise.fulfill(products)
            }).catch(promise.reject(_:))
        return promise
    }

    func fetchAll() -> Promise<[ProductModel]>{
        return Promise(NSError(domain: "fetchAllNotAllowed", code: 500, userInfo: nil))
    }

    @discardableResult func save(categoryId: String,  stocks: [ProductModel]) -> Promise<Void>{
        return Promise(NSError(domain: "SaveNotAllowed", code: 500, userInfo: nil))
    }

    @discardableResult func distroy() -> Promise<Void> {
        return Promise(NSError(domain: "FetchAllNotAllowed", code: 500, userInfo: nil))
    }
}
