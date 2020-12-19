//
//  BaseUseCaseProtocol.swift
//  FoodicsAssesment
//
//  Created by mohamed gamal on 12/17/20.
//

import Foundation
import Promises

protocol BaseUseCaseProtocol {
    func process<T: Codable>(_ outputType: T.Type) -> Promise<T>
}
class BaseUseCase: BaseUseCaseProtocol {
    
    @Injected var network: NetworkManagerProtocol
    @Injected var provider: APIRequestProviderProtocol

    func process<T>(_ outputType: T.Type) -> Promise<T> {
        fatalError("You must implement this method in the sub class")
    }
}
