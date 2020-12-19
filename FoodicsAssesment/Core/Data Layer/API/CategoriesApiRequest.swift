//
//  CategoriesApiRequest.swift
//  FoodicsAssesment
//
//  Created by mohamed gamal on 12/17/20.
//

import Foundation
class GetCategoriesApiRequest: BaseAPIRequest {
    var pageNumber:Int
     init(pageSize: Int, pageNumber: Int) {
        self.pageNumber = pageNumber
        super.init()
        method = .get
        authorization = .barerToken
        path = "/v5/categories/"

    }
    override func queryParams() -> [String : String]? {
        ["page":"\(pageNumber)"]
    }
}
