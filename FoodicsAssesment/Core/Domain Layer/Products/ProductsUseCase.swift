//
//  ProductsUseCase.swift
//  FoodicsAssesment
//
//  Created by mohamed gamal on 12/17/20.
//

import Foundation
import Promises

class ProductsUseCase: BaseCodableUseCase {
    
    var catId: String
    init(catId: String) {
        self.catId = catId
    }
    override func process<T: Codable>(_ outputType: T.Type) -> Promise<T> {
        return performProducts(outputType).then(getProducts)
    }
    
    private func performProducts<T: Codable>(_ outPutType: T.Type) -> Promise<T> {
        let getProductsRequest = ProductsApiRequest(catId: catId)
        return network.perform(apiRequest: getProductsRequest,
                               providerType: self.providers[0],
                               outputType: outPutType)
    }
    
    private func getProducts<T: Codable>(_ ProductsResponse: T) -> Promise<T> {
        if let Products = ProductsResponse as? BaseResponse<Products> {
            print(Products)
        }
        return Promise<T>.init(ProductsResponse)
    }
}

