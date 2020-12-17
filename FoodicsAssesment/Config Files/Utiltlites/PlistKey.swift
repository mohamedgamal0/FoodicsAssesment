//
//  PlistKey.swift
//  FoodicsAssesment
//
//  Created by mohamed gamal on 12/17/20.
//

import Foundation

public enum PlistKey {
    case baseDomain
    case timeoutInterval
    case urlProtocol
    case port
    case tokenExpirationCode
    
    func value() -> String {
        switch self {
        case .baseDomain: return "BaseDomain"
        case .timeoutInterval: return "TimeoutInterval"
        case .urlProtocol: return "URLProtocol"
        case .port: return "Port"
        case .tokenExpirationCode: return "TokenExpirationCode"
        }
    }
}
