//
//  APIAuthorization.swift
//  FoodicsAssesment
//
//  Created by mohamed gamal on 12/17/20.
//

import Foundation

enum APIAuthorization {
    case none
    case barerToken
    var authData: Any {
        switch self {
        case .none:
            return []
        case .barerToken:
            let token = FoodicsConstants.foodicsApiToken
            return ["Authorization": "Bearer \(token)"]
        }
    }
}
