//
//  BaseAPIRequest.swift
//  FoodicsAssesment
//
//  Created by mohamed gamal on 12/17/20.
//

import Foundation
class BaseAPIRequest: APIRequestProtocol {
    var queryParamss: [String: String]?
    var scheme: String
    var host: String
    var portNumber: Int
    var path: String
    var authorization: APIAuthorization
    var method: HTTPMethod
    var queryBody: Any?
    var headers: [String: String]
    var queryItems: [URLQueryItem]? {
        return queryParams()?.map({ URLQueryItem.init(name: $0.key, value: $0.value)})
    }
    var url: URL {
        var urlComponant = URLComponents()
        urlComponant.scheme = self.scheme
        urlComponant.host = self.host
        urlComponant.port = self.portNumber
        urlComponant.path = "\(self.path)"
        urlComponant.queryItems = self.queryItems
        return urlComponant.url!
    }
    var requestURL: URLRequest {
        let timeoutInterval = Environment().configration(.timeoutInterval).doubleValue
        var request = URLRequest(url: self.url,
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: timeoutInterval)
        switch authorization {
        case .barerToken:
            guard let header = authorization.authData as? [String: String] else {
                fatalError("bearerToken header must be as [String:String]")
            }
            headers.merge(header) { (_, new) in new }
        case .none:
            break
        }
        request.allHTTPHeaderFields = self.headers
        request.httpMethod = self.method.rawValue
        var bodyData: Data?
        if let queryBody = self.queryBody as? [String: Any] {
            bodyData = try? JSONSerialization.data(withJSONObject: queryBody, options: [])
        } else if let queryBody = self.queryBody as? Data {
            request.httpBody = queryBody
        } else if let queryBody =  self.queryBody as? String {
            bodyData = queryBody.data(using: .utf8)
        }
        request.httpBody = bodyData
        return request
    }
    init() {
        scheme = "\(Environment().configration(.urlProtocol))"
        host = "\(Environment().configration(.baseDomain))"
        portNumber = Environment().configration(.port).integerValue
        path = ""
        authorization = .none
        method = .get
        headers = ["Content-Type": "application/json",
                   "Accept":"application/json"]
    }
    func queryParams() -> [String: String]? {
        return nil
    }
}
