//
//  APIRequestProviderError.swift
//  FoodicsAssesment
//
//  Created by mohamed gamal on 12/17/20.
//

import Foundation

enum APIRequestProviderError: Error {
    case noInternet(message: String)
    case server(statusCode: Int, data: Data?)
    case requestFiled(error: Error)
    
    var reason: String {
        switch self {
        case .noInternet(let eMessage):
            return eMessage
        case .server(let statusCode, _):
            return "Request Failed with status Code \(statusCode)"
        case .requestFiled(let error):
            return error.localizedDescription
        }
    }
}
