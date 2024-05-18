//
//  RouterProtocol.swift
//  ToughCookie
//
//  Created by 이중엽 on 5/18/24.
//

import Foundation
import Alamofire

protocol RouterProtocol: URLRequestConvertible {
    
    var baseURL: String { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
    var header: [String: String] { get }
    var body: Data? { get }
}

extension RouterProtocol {
    
    func asURLRequest() throws -> URLRequest {
        
        let url = try baseURL.asURL()
        var urlRequest = try URLRequest(url: url.appendingPathComponent(path), method: method)
        urlRequest.allHTTPHeaderFields = header
        urlRequest.httpBody = body
        
        var queryItems = [URLQueryItem]()
        
        if let parameters {
            
            for value in parameters {
                let queryItem = URLQueryItem(name: value.key, value: "\(value.value)")
                queryItems.append(queryItem)
            }
        }
        
        urlRequest.url?.append(queryItems: queryItems)
        
        return urlRequest
    }
}
