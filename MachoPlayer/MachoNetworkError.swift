//
//  MachoNetworkError.swift
//  MachoPlayer
//
//  Created by 성희장 on 1/25/24.
//

import Foundation

enum MachoNetworkError: Error {
    case emptyResponse
    
    case networkError
    case badURL
    case internalError
    case authFailed
    case unKnownStatus    
}


enum MachoJSONDecodeError: Error {
    case emptyData
    case dataCorrupted
    case keyNotFound
    case valueNotFound
    case typeMismatch
}
