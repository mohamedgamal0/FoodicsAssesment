//
//  APIRequestProtocol.swift
//  FoodicsAssesment
//
//  Created by mohamed gamal on 12/17/20.
//

import Foundation

protocol APIRequestProtocol: AnyObject {
    var scheme: String { get }
    var host: String { get }
    var url: URL { get }
    var portNumber: Int { get }
    var path: String { get }
    func queryParams() -> [String: String]?
    var authorization: APIAuthorization { get }
    var requestURL: URLRequest { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get set }
    var queryBody: Any? { get }
}

enum HTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}
