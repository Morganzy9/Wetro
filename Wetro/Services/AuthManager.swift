//
//  AuthManager.swift
//  Wetro
//
//  Created by Ислам Пулатов on 1/5/24.
//

import Foundation

final class AuthManager {
    
    static let shared = AuthManager()
    
    private init() {}
    
    struct Constants {
        static let clientID = "11e9a62378e2443fb80a41efadfee150"
        static let clientSecret = "98c0c19a1e014f249b9bd70ea189e95b"
        static let tokenAPIURL = "https://accounts.spotify.com/api/token"
    }
    
    var signInURL: URL? {
        let base = "https://accounts.spotify.com/authorize"
        let redirectURI = "https%3A%2F%2Fwww.google.com%2F"
        let scope = "user-top-read,user-read-playback-state,user-modify-playback-state,playlist-read-private,playlist-read-collaborative"
        let signUrl = "\(base)?client_id=\(Constants.clientID)&response_type=code&redirect_uri=\(redirectURI)&scope=\(scope)&show_dialog=TRUE"
        return URL(string: signUrl)
    }
    
    func exchangeCodeForToken(code: String, completion: @escaping ((Bool) -> Void)) {
        guard let url = URL(string: Constants.tokenAPIURL) else { return }
        
        var urlComponents = URLComponents()
        urlComponents.queryItems = [
            URLQueryItem(name: "grant_type", value: "authorization_code"),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "redirect_uri", value: "https://www.google.com/")
        ]
        
                
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = urlComponents.query?.data(using: .utf8)
        
        let basicToken = Constants.clientID+":"+Constants.clientSecret
        let data = basicToken.data(using: .utf8)
        guard let base64String = data?.base64EncodedString() else {
            completion(false)
            return
        }
        
        request.setValue("Basic \(base64String)", forHTTPHeaderField: "Authorization")
        
        let _ = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else { 
                completion(false)
                return
            }
            
            do {
                let json = try JSONDecoder().decode(WTToken.self, from: data)
                PersistenceManager.saveAccessToken(accessToken: json.accessToken)
                PersistenceManager.saveRefreshToken(refreshToken: json.refreshToken)
            } catch {
                print("DEBUG CONSOLE: \(error.localizedDescription)")
                completion(false)
            }
            
        }.resume()
    }
    
}
