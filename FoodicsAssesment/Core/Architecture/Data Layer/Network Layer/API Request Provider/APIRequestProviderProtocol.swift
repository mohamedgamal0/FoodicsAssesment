//
//  APIRequestProviderProtocol.swift
//  FoodicsAssesment
//
//  Created by mohamed gamal on 12/17/20.
//

import Foundation

protocol APIRequestProviderProtocol {
    typealias APIRequestCompletion = (_ result: Result<Data, APIRequestProviderError>) -> Void
    func perform(apiRequest: APIRequestProtocol, completion: @escaping APIRequestCompletion)
}
