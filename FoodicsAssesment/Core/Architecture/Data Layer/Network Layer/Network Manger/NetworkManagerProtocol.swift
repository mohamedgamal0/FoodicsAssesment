//
//  NetworkManagerProtocol.swift
//  FoodicsAssesment
//
//  Created by mohamed gamal on 12/17/20.
//

import Foundation
import Promises

protocol NetworkManagerProtocol {
    func perform<T: Codable>(apiRequest: APIRequestProtocol,
                             providerType: APIRequestProviderProtocol,
                             outputType: T.Type) -> Promise<T>
}

