//
//  WTService.swift
//  Wetro
//
//  Created by Ислам Пулатов on 12/18/23.
//

import UIKit

enum WTServiceError: Error {
    case failedToCreateRequest
    case failedToGetData
    case failedToFail
}

///  Primary API service to get data
final class WTService {
    
    /// Singleton pattern
    static let shared = WTService()
    
    private init() {}
    
    ///   Send API Call
    /// - Parameters:
    ///   - request:  Request instance
    ///   - type: Type of object that returns
    ///   - completion:  Return Data or Error
    public func execute<T: Codable>(_ request: WTRequest, expecting type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        guard let urlRequest = self.request(from: request) else {
            completion(.failure(WTServiceError.failedToCreateRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            
            guard let data = data, error == nil else {
                completion(.failure(error ?? WTServiceError.failedToGetData))
                return
            }
            
            // Decode response
            do {
                let result = try JSONDecoder().decode(type.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
            
        }
        task.resume()
    }
    
    //  MARK: - Private
    
    private func request(from rmRequest: WTRequest) -> URLRequest? {
        guard let url = rmRequest.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = rmRequest.httpMethod
        
        return request
    }
    
}

