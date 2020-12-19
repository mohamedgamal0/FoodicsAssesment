//
//  ProductsApiRequest.swift
//  FoodicsAssesment
//
//  Created by mohamed gamal on 12/17/20.
//

import Foundation

class GetProductsApiRequest: BaseAPIRequest {
    var categoryId: String
    init(categoryId: String,
         pageSize:Int = 50,
         pageNumber: Int) {
        self.categoryId = categoryId
        super.init()
        method = .get
        authorization = .barerToken
        path = "/v5/products"
    }
    
    override func queryParams() -> [String : String]? {
        return ["category":categoryId]
    }
}
