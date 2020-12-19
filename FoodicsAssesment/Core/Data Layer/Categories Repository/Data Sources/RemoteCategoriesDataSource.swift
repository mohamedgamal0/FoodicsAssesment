//
//  RemoteCategoriesDataSource.swift
//  FoodicsAssesment
//
//  Created by mohamed gamal on 12/19/20.
//

import Foundation
import Promises

class RemoteCategoriesDataSource: CategoriesDataSource {

    @Injected private var network: NetworkManagerProtocol
    @Injected private var provider: APIRequestProviderProtocol

    func fetch(pageSize: Int, pageNumber: Int) -> Promise<[CategoryModel]> {
        let promise = Promise<[CategoryModel]>.pending()
        let getCategoriesRequest = GetCategoriesApiRequest(pageSize: pageSize,
                                                           pageNumber: pageNumber)
        network.perform(apiRequest: getCategoriesRequest,
                        providerType: self.provider,
                        outputType: BaseResponse<[CategoryAPIModel]>.self)
            .then({ (response)  in
                let categories = response.data?.map({$0.toCategoryModel()}) ?? []
                promise.fulfill(categories)
            }).catch(promise.reject(_:))
        return promise
    }

    func fetchAll() -> Promise<[CategoryModel]>{
        return Promise(NSError(domain: "fetchAllNotAllowed", code: 500, userInfo: nil))
    }

    @discardableResult func save( _ stocks: [CategoryModel]) -> Promise<Void>{
        return Promise(NSError(domain: "SaveNotAllowed", code: 500, userInfo: nil))
    }

    @discardableResult func save( _ stock: CategoryModel) -> Promise<Void> {
        return Promise(NSError(domain: "SaveNotAllowed", code: 500, userInfo: nil))
    }

    @discardableResult func distroy() -> Promise<Void> {
        return Promise(NSError(domain: "FetchAllNotAllowed", code: 500, userInfo: nil))
    }
}
