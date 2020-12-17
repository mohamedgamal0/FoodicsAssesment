//
//  CategoriesUseCase.swift
//  FoodicsAssesment
//
//  Created by mohamed gamal on 12/17/20.
//

import Foundation
import Promises

class CategoriesUseCase: BaseCodableUseCase {
    override func process<T: Codable>(_ outputType: T.Type) -> Promise<T> {
        return performCategories(outputType).then(getCategories)
    }

    private func performCategories<T: Codable>(_ outPutType: T.Type) -> Promise<T> {
        let getCategoriesRequest = CategoriesApiRequest()
        return network.perform(apiRequest: getCategoriesRequest,
                               providerType: self.providers[0],
                               outputType: outPutType)
    }

    private func getCategories<T: Codable>(_ categoriesResponse: T) -> Promise<T> {
        if let categories = categoriesResponse as? BaseResponse<Categories> {
            print(categories)
        }
        return Promise<T>.init(categoriesResponse)
    }
}

