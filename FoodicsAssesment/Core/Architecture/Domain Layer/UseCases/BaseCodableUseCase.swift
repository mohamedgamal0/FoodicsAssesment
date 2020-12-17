//
//  BaseCodableUseCase.swift
//  FoodicsAssesment
//
//  Created by mohamed gamal on 12/17/20.
//

import Foundation
import Promises

class BaseCodableUseCase: BaseUseCase {
    
    override func process<T: Codable>(_ outputType: T.Type) -> Promise<T> {
        fatalError("You must implement this method in the sub class")
    }
    
    override func execute<T: Codable>(_ outputType: T.Type) -> Promise<T> {
        do {
            extract()
            try validate()
            willProcess?()
            return process(outputType)
        } catch let error {
            return Promise<T>.init(error)
        }
    }
    
    func perform<T: Codable>(apiRequest: APIRequestProtocol) -> Promise<T> {
        network.perform(apiRequest: apiRequest, providerType: self.providers[0], outputType: T.self)
    }
}
