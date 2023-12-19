//
//  LinkAccountVCViewModel.swift
//  Wetro
//
//  Created by Ислам Пулатов on 12/19/23.
//

import UIKit
import SafariServices
import StoreKit

final class LinkAccountVCViewModel {
    
    //  MARK: - Variables & Constants
    
    private let limit           = "50"
    private let offset          = "0"
    private let clientID        = "11e9a62378e2443fb80a41efadfee150"
    private let clientSecret    = "98c0c19a1e014f249b9bd70ea189e95b"
    
    private let encodedID  = "MTFlOWE2MjM3OGUyNDQzZmI4MGE0MWVmYWRmZWUxNTA6OThjMGMxOWExZTAxNGYyNDliOWJkNzBlYTE4OWU5NWI="
    
    //  MARK: - Private Methods
    //    https://accounts.spotify.com/api/token?grant_type=authorization_code&code=AQDT1Kw5iHeOYZiZjOYZBwuQ4odMf0pE18E_N8n3QsDEVbq32SFcLZvtkqACkJZUhCLYCtdJxYqVmdoYUIOK3RnqdrHhwxVzQ3cENUs7e8MRr0BMJmpDw-Y4fVJrx7oAodwZs5zWce7cljNItYn_4HxLQUDnZSdR2xGmSMjyKX4TVc4UYlPj6C4c&redirect_uri=https%3A%2F%2Fwww.google.com%2Fb
    
//    private func authUser(with code: String, completion: @escaping (String?) -> Void) {
//        var requestBodyComponents = URLComponents()
//        let requestHeaders: [String:String] = [HeaderField.authorization : "Basic \(encodedID)",
//                                               HeaderField.contentType : "application/x-www-form-urlencoded"]
//        
//        requestBodyComponents.queryItems = [URLQueryItem(name: HeaderField.grantType, value: "authorization_code"),
//                                            URLQueryItem(name: HeaderField.code, value: endpoint),
//                                            URLQueryItem(name: HeaderField.redirectUri, value: redirectUrl)]
//        
//        guard let url = URL(string: "https://accounts.spotify.com/api/token") else { return }
//        var request                 = URLRequest(url: url)
//        request.httpMethod          = "POST"
//        request.allHTTPHeaderFields = requestHeaders
//        request.httpBody            = requestBodyComponents.query?.data(using: .utf8)
//        
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            
//            if let _            = error { print("completeAuthorizeRequest: error"); return }
//            guard let response  = response as? HTTPURLResponse, response.statusCode == 200 else { print("completeAuthorizeRequest: response"); return }
//            guard let data      = data else { print("completeAuthorizeRequest: data"); return }
//            
//            do {
//                let decoder                     = JSONDecoder()
//                decoder.keyDecodingStrategy     = .convertFromSnakeCase
//                let token                       = try decoder.decode(WTToken.self, from: data)
//                
//                PersistenceManager.saveAccessToken(accessToken: token.accessToken)
//                PersistenceManager.saveRefreshToken(refreshToken: token.refreshToken)
//                
//                completion(token.accessToken)
//                return
//            } catch {
//                print("completeAuthorizeRequest: catch")
//            }
//        }
//        task.resume()
//    }
//    
    
    func authorizeUser(with urlString: String) {
        let index = urlString.index(urlString.startIndex, offsetBy: 33)
        let code = String(urlString.suffix(from: index))
        
        
    }
    
}
