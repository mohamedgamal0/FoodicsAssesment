//
//  APIManager.swift
//  FoodicsAssesment
//
//  Created by mohamed gamal on 12/17/20.
//

import Foundation
import Promises

class APIManager: NetworkManagerProtocol {
    
    func perform<T: Codable>(apiRequest: APIRequestProtocol,
                             providerType: APIRequestProviderProtocol,
                             outputType: T.Type) -> Promise<T> {
        return call(apiRequest: apiRequest,
                    providerType: providerType,
                    outputType: outputType)
    }
    
    private func call<T: Codable>(apiRequest: APIRequestProtocol,
                                  providerType: APIRequestProviderProtocol,
                                  outputType: T.Type) -> Promise<T> {
        let promise = Promise<T>.pending()
        providerType.perform(apiRequest: apiRequest, completion: { [weak self] result in
            if let result = self?.validate(result: result, outputType: outputType) {
                switch result {
                case .success(let data):
                    promise.fulfill(data)
                case .failure(let error):
                    promise.reject(error)
                }
            }
        })
        
        return promise
    }
    
    private func validate<T: Codable>(result: Result<Data, APIRequestProviderError>,
                                      outputType: T.Type) -> Result<T, APIManagerError> {
        let returnedresult: Result<T, APIManagerError>
        
        switch result {
        case .failure(let error):
            switch error {
            case .noInternet(let message):
                returnedresult = .failure(.noInternet(message: message))
            case .requestFiled(let error):
                returnedresult = .failure(.requestFailed(message: error.localizedDescription))
            case .server( _, let data):
                let decoder = JSONDecoder()
                if let data = data, let error = try? decoder.decode(ErrorModel.self, from: data) {
                    returnedresult = .failure(.errorModel(errorModel: error))
                } else {
                    let error = ErrorModel(message: "API Failure Error")
                    returnedresult = .failure(.errorModel(errorModel: error))
                }
            }
        case .success(let data):
            if let decoded = try? JSONDecoder().decode(outputType, from: data) {
                returnedresult = .success(decoded)
            } else if let error = try? JSONDecoder().decode(ErrorModel.self, from: data),
                      !(error.message ?? "").isEmpty {
                returnedresult = .failure(.errorModel(errorModel: error))
            } else if let decoded = String(bytes: data, encoding: .utf8) as? T {
                returnedresult = .success(decoded)
            } else {
                returnedresult = .failure(.requestFailed(message: "API Failure Error"))
            }
        }
        return returnedresult
    }
}
