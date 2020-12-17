//
//  APIMangerError.swift
//  FoodicsAssesment
//
//  Created by mohamed gamal on 12/17/20.
//

import Foundation

enum APIManagerError: Error {
    case requestFailed(message: String)
    case errorModel(errorModel: ErrorModel)
    case noInternet(message: String)
    
    var message: String {
        switch self {
        case .requestFailed(let message):
            return message
        case .errorModel(let errorModel):
            return (errorModel.message) ?? ""
        case .noInternet(let message):
            return message
        }
    }
}
