//
//  Error+Extension.swift
//  Icon Shop
//
//  Created by mohamed gamal on 9/2/20.
//  Copyright © 2020 mohamed gamal. All rights reserved.
//

import Foundation
extension NSError {
    static let apiFailureError = NSError(domain: "API Failure Error",
                                         code: 404,
                                         userInfo: nil)
    static let cancelError = NSError(domain: "cancel Error",
                                     code: 4000,
                                     userInfo: nil)
    
    static let noInternet = NSError(domain: "NoInternet Error",
                                    code: 5005,
                                    userInfo: nil)
}
extension Error {
    
    var message: String {
        if let apiError = self as? APIManagerError {
            return apiError.message
        } else if let apiError = self as? APIRequestProviderError {
            return apiError.reason
        } else {
            let error = self as NSError
            return error.domain
        }
    }
    
    var isNoInternet: Bool {
        message == "No Internet Error"
    }
}
