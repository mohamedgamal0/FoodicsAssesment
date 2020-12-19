//
//  ProductsApiRequest.swift
//  FoodicsAssesment
//
//  Created by mohamed gamal on 12/17/20.
//

import Foundation

class GetProductsApiRequest: BaseAPIRequest {
    var categoryId: String
    var pageNumber:Int
    init(categoryId: String,
         pageSize:Int ,
         pageNumber: Int) {
        self.categoryId = categoryId
        self.pageNumber = pageNumber
        super.init()
        method = .get
        authorization = .barerToken
        path = "/v5/products"
    }
    
    override func queryParams() -> [String : String]? {
        return ["category":categoryId,
                "page": "\(pageNumber)"]
    }
}
