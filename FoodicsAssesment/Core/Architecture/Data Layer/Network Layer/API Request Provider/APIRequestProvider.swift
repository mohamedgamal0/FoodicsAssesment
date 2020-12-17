//
//  APIRequestProvider.swift
//  FoodicsAssesment
//
//  Created by mohamed gamal on 12/17/20.
//

import Foundation
class APIRequestProvider: APIRequestProviderProtocol {
    
    @Injected var internetManager: InternetManagerProtocol
    
    func perform(apiRequest: APIRequestProtocol, completion: @escaping APIRequestCompletion) {
        guard internetManager.isInternetConnectionAvailable() else {
            completion(Result<Data, APIRequestProviderError>.failure(.noInternet(message: "NO Internet")))
            return
        }
        performRequest(apiRequest.requestURL, completion: completion)
    }
    
    private func performRequest(_ request: URLRequest, completion: @escaping APIRequestCompletion) {
        let urlSession = URLSession(configuration: .default)
        let dataTask = urlSession.dataTask(with: request) { data, response, error in
            if let error = error {
                let failure = APIRequestProviderError.requestFiled(error: error)
                completion(Result<Data, APIRequestProviderError>.failure(failure))
                return
            }
            
            if let response = response as? HTTPURLResponse {
                let statusCode = response.statusCode
                switch statusCode {
                case 200...299:
                    let success = data ?? Data.init()
                    completion(Result<Data, APIRequestProviderError>.success(success))
                default:
                    let failure: APIRequestProviderError = .server(statusCode: statusCode, data: data)
                    completion(Result<Data, APIRequestProviderError>.failure(failure))
                }
            }
        }
        dataTask.resume()
    }
}
