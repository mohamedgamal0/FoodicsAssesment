//
//  ProductsApiRequest.swift
//  FoodicsAssesment
//
//  Created by mohamed gamal on 12/17/20.
//

import Foundation

class ProductsApiRequest: BaseAPIRequest {
    var catId: String
    init(catId: String) {
        self.catId = catId
        super.init()
        method = .get
        authorization = .barerToken
        path = "/v5/products"
    }
    
    override func queryParams() -> [String : String]? {
        return ["category":catId]
    }
}
