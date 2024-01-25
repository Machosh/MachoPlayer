//
//  MachoNetwork.swift
//  MachoPlayer
//
//  Created by 성희장 on 1/25/24.
//

import Foundation

public enum MachoNetwork {
    
}

public extension MachoNetwork {
    struct URLInfo {
        let scheme: String
        let host: String
        let port: Int?
        let path: String
        let query: [String: Any]?
        
        public init(scheme: String = "https",
                    host: String,
                    port: Int? = nil,
                    path: String,
                    query: [String : Any]? = nil) {
            self.scheme = scheme
            self.host = host
            self.port = port
            self.path = path
            self.query = query
        }
        
        var url: URL{
            var components = URLComponents()
            components.scheme = scheme
            components.host = host
            components.port = port
            components.path = path
            components.queryItems = query?.compactMap{
                URLQueryItem(
                    name: $0.key,
                    value: "\($0.value)"
                )
            }
            
            guard let url = components.url
            else{
                assertionFailure("MyNetwork wrong requestURL")
                return .init(string: "")!
            }
            
            return url
        }
    }
}

public extension MachoNetwork{
    enum Method: String{
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }
}

public struct EmptyParameter: Codable {}
public struct EmptyResponse: Codable {}
