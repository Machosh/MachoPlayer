//
//  MachoNetworkRepository.swift
//  MachoPlayer
//
//  Created by 성희장 on 1/25/24.
//

import Foundation

public protocol MachoNetworkRepository {
    typealias URLInfo = MachoNetwork.URLInfo
    typealias RequestInfo = MachoNetwork.RequestInfo
    
    associatedtype Parameter: Encodable
    associatedtype Response: Decodable
    
    var urlInfo: MachoNetwork.URLInfo { get }
    var requestInfo: RequestInfo<Parameter> { get }
    
}

public extension MachoNetworkRepository{
    func asyncRequest(_ cachePolicy: URLRequest.CachePolicy? = .useProtocolCachePolicy) async throws -> Response{
        let url = urlInfo.url
        var request = requestInfo.requests(url: url)
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let urlResponse = (response as? HTTPURLResponse) else { throw MachoNetworkError.emptyResponse }
        if urlResponse.statusCode == 200 || urlResponse.statusCode == 201{
            guard data.count != 0 else{ throw MachoJSONDecodeError.emptyData }
            do{
                let response = try JSONDecoder().decode(Response.self, from: data)
                return response
            }
            catch DecodingError.dataCorrupted(_) { throw MachoJSONDecodeError.dataCorrupted }
            catch DecodingError.keyNotFound(_, _) { throw MachoJSONDecodeError.keyNotFound }
            catch DecodingError.valueNotFound(_, _) { throw MachoJSONDecodeError.valueNotFound }
            catch DecodingError.typeMismatch(_, _) { throw MachoJSONDecodeError.typeMismatch }
            catch { throw error }
        }
        else if urlResponse.statusCode == 403{ throw MachoNetworkError.authFailed }
        else if urlResponse.statusCode == 404{ throw MachoNetworkError.badURL }
        else if urlResponse.statusCode == 500{ throw MachoNetworkError.internalError }
        else{
            assertionFailure("network error. status : \(urlResponse.statusCode)\nrequestURL: \(url)")
            throw MachoNetworkError.unKnownStatus
        }
    }
    
    func request(_ cachePolicy: URLRequest.CachePolicy? = nil, completion: @escaping ( (Result<Response, Error>) -> Void) ) {
        let url = urlInfo.url
        var request = requestInfo.requests(url: url)
        if let cachePolicy = cachePolicy{
            request.cachePolicy = cachePolicy
        }else{
            request.cachePolicy = .useProtocolCachePolicy
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error{
                completion(.failure(error))
                return
            }
            guard let data = data else {
                assertionFailure("PlusNetworkDelegate response nil Data")
                return
            }
            guard let urlResponse = response as? HTTPURLResponse
            else{
                assertionFailure("PlusNetworkDelegate response wrong response")
                return
            }
            if urlResponse.statusCode == 200 || urlResponse.statusCode == 201{
                guard data.count != 0 else{
                    completion(.failure(MachoJSONDecodeError.emptyData))
                    return
                }
                do{
                    let response = try JSONDecoder().decode(Response.self, from: data)
                    completion(.success(response))
                }catch DecodingError.dataCorrupted(let context) {
                    print(context)
                    print("data : \(data)")
                    completion(.failure(MachoJSONDecodeError.dataCorrupted))
                } catch DecodingError.keyNotFound(let key, let context) {
                    print("Key '\(key)' not found:", context.debugDescription)
                    print("requestURL: \(url)\ncodingPath:", context.codingPath)
                    completion(.failure(MachoJSONDecodeError.keyNotFound))
                } catch DecodingError.valueNotFound(let value, let context) {
                    print("Value '\(value)' not found:", context.debugDescription)
                    print("requestURL: \(url)\ncodingPath:", context.codingPath)
                    completion(.failure(MachoJSONDecodeError.valueNotFound))
                } catch DecodingError.typeMismatch(let type, let context) {
                    print("Type '\(type)' mismatch:", context.debugDescription)
                    print("requestURL: \(url)\ncodingPath:", context.codingPath)
                    completion(.failure(MachoJSONDecodeError.typeMismatch))
                } catch{
                    completion(.failure(error))
                }
            }else if urlResponse.statusCode == 403{
                completion(.failure(MachoNetworkError.authFailed))
            }else if urlResponse.statusCode == 404{
                completion(.failure(MachoNetworkError.badURL))
            }else if urlResponse.statusCode == 500{
                completion(.failure(MachoNetworkError.internalError))
            }else{
                assertionFailure("network error. status : \(urlResponse.statusCode)\nrequestURL: \(url)")
                return
            }
        }
        
        task.resume()
    }
}
