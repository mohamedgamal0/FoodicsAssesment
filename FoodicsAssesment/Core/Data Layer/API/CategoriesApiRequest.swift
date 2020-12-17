//
//  CategoriesApiRequest.swift
//  FoodicsAssesment
//
//  Created by mohamed gamal on 12/17/20.
//

import Foundation
class CategoriesApiRequest: BaseAPIRequest {
    override init() {
        super.init()
        method = .get
        authorization = .barerToken
        path = "/v5/categories/"
    }
}
