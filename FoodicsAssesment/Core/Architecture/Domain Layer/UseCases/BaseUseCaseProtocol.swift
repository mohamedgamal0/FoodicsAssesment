//
//  BaseUseCaseProtocol.swift
//  FoodicsAssesment
//
//  Created by mohamed gamal on 12/17/20.
//

import Foundation
import Promises

protocol BaseUseCaseProtocol {
    var willProcess: (() -> Void)? {get set}
    func execute<T: Codable>(_ outputType: T.Type) -> Promise<T>
}
class BaseUseCase: BaseUseCaseProtocol {
    
    @Injected var network: NetworkManagerProtocol
    var providers: [APIRequestProviderProtocol] = [Resolver.resolve()]
    
    // it will be injected by UseCase consumer (e.g. presenter)
    var willProcess: (() -> Void)?
    
    func extract() {}
    func validate() throws {}
    func process<T: Codable>(_ outputType: T.Type) -> Promise<T> {
        fatalError("You must implement this method in the sub class")
    }
    
    func execute<T: Codable>(_ outputType: T.Type) -> Promise<T> {
        do {
            extract()
            try validate()
            willProcess?()
            return process(outputType)
        } catch let error {
            return Promise<T>.init(error)
        }
    }
    
}
