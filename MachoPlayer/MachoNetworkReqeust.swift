//
//  MachoNetworkReqeust.swift
//  MachoPlayer
//
//  Created by 성희장 on 1/25/24.
//

import Foundation

public extension MachoNetwork {
    struct RequestInfo<T: Encodable> {
        var method: Method
        var headers: [String: String]?
        var parameters: T?
        var formData: [String: Any]?
        
        public init(
            method: Method,
            headers: [String : String]? = nil,
            parameters: T? = nil,
            formData: [String: String]? = nil
        ) {
            self.method = method
            self.headers = headers
            self.parameters = parameters
            self.formData = formData
        }
                
        func requests(url: URL) -> URLRequest{
            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue
//            request.httpBody = parameters.flatMap{
//                try? JSONEncoder().encode($0)
//            }
            if parameters != nil{
                request.httpBody = parameters.flatMap{
                    try? JSONEncoder().encode($0)
                }
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            }
            headers.map{
                request.allHTTPHeaderFields?.merge($0) { lhs, rhs in lhs }
            }
            
            return request
        }
        
        func request(url: URL, cachePolicy: URLRequest.CachePolicy) -> URLRequest{
            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue
            request.httpBody = parameters.flatMap{
                try? JSONEncoder().encode($0)
            }
            headers.map{
                request.allHTTPHeaderFields?.merge($0) { lhs, rhs in lhs }
            }
            request.cachePolicy = cachePolicy
            
            return request
        }
                
        func upload(url: URL) -> URLRequest{
            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue
            let boundary = "MachoMultipart"
            var body = Data()
            
            if let formData = formData{
                for (key, value) in formData{
                    body.appendString("--\(boundary)\r\n")
                    body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                    body.appendString("\(value)\r\n")
                }
                body.appendString("--\(boundary)--\r\n")
                request.httpBody = body
                request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            }
            
            headers.map{
                request.allHTTPHeaderFields?.merge($0) { lhs, rhs in lhs }
            }
            
            return request
        }
    }
}

fileprivate extension Data {
    mutating func appendString(_ string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        append(data!)
    }
}
