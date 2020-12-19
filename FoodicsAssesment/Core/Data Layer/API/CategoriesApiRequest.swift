//
//  CategoriesApiRequest.swift
//  FoodicsAssesment
//
//  Created by mohamed gamal on 12/17/20.
//

import Foundation
class GetCategoriesApiRequest: BaseAPIRequest {
     init(pageSize: Int, pageNumber: Int) {
        super.init()
        method = .get
        authorization = .barerToken
        path = "/v5/categories/"
    }
}
