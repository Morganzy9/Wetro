//
//  WTImageLoader.swift
//  Wetro
//
//  Created by Ислам Пулатов on 1/29/24.
//

import Foundation
import Combine

final class WTImageLoader {
    
    static let shared = WTImageLoader()
    
    private init() {}
    
    private var imageDataCache = NSCache<NSString, NSData>()
    
    /// Get image content URL
    /// - Parameters:
    ///   - url: source URL
    /// - Returns: Publisher emitting the loaded image data or an error
    func downloadImagePublisher(_ url: URL) -> AnyPublisher<Data, Error> {
        let key = url.absoluteString as NSString
        
        if let data = imageDataCache.object(forKey: key) {
            return Just(data as Data)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse,
                      200..<300 ~= httpResponse.statusCode else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .tryMap { data in
                let value = data as NSData
                self.imageDataCache.setObject(value, forKey: key)
                return data
            }
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
}
