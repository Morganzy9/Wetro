//
//  WTService.swift
//  Wetro
//
//  Created by Ислам Пулатов on 12/18/23.
//

import Foundation
import Combine

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
    func execute<T: Codable>(_ request: WTRequest, expecting type: T.Type) -> AnyPublisher<T, Error> {
        guard let urlRequest = self.request(from: request) else {
            return Fail(error: WTServiceError.failedToCreateRequest)
                .eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .map { data, response in
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    
    //  MARK: - Private
    
    private func request(from wtRequest: WTRequest) -> URLRequest? {
        guard let url = wtRequest.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = wtRequest.httpMethod
        wtRequest.headers.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        return request
    }
    
}

