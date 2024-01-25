//
//  MovieAPI.swift
//  MachoPlayer
//
//  Created by 성희장 on 1/25/24.
//

import Foundation

public extension MachoNetwork.URLInfo{
    
    static func fetchMovies() -> Self{
        self.init(
            host: "",
            path: ""
        )
    }
    
}

public enum MovieAPI{}

public extension MovieAPI{
    
    struct FetchMovies: MachoNetworkRepository{
        public let urlInfo: MachoNetwork.URLInfo
        public let requestInfo: MachoNetwork.RequestInfo<EmptyParameter> = .init(method: .get)
        
        public init(){ self.urlInfo = .fetchMovies() }
        
        public struct Response: Decodable{
            let test: String
            
            enum CodingKeys: String, CodingKey{
                case test
            }
        }
    }
    
}
