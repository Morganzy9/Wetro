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
    
    struct WetroConstants {
        static let clientID = "11e9a62378e2443fb80a41efadfee150"
        static let clientSecret = "98c0c19a1e014f249b9bd70ea189e95b"
        static let tokenAPIURL = "https://accounts.spotify.com/api/token"
        static let redirectURI = "https%3A%2F%2Fwww.google.com%2F"
        static let scopes = "user-top-read,user-read-playback-state,user-modify-playback-state,playlist-read-private,playlist-read-collaborative"
    }
    
    var signInURL: URL? {
        let base = "https://accounts.spotify.com/authorize"
        let signUrl = "\(base)?client_id=\(WetroConstants.clientID)&response_type=code&redirect_uri=\(WetroConstants.redirectURI)&scope=\(WetroConstants.scopes)&show_dialog=TRUE"
        return URL(string: signUrl)
    }
    
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter
    }()
    
    //  MARK: - Closures
    
    var isSignedIn: Bool {
        return PersistenceManager.retrieveAccessToken() != nil
    }
    
    var shouldRefreshToken: Bool {
        guard let expirationDateString = PersistenceManager.retrieveRefreshToken() else { return false}
        guard let expirationDate = dateFormatter.date(from: expirationDateString) else {
            return false
        }
        
        let currentDate = Date()
        let fiveMinutes: TimeInterval = 300
        let expirationThreshold = currentDate.addingTimeInterval(fiveMinutes)
        
        return expirationThreshold >= expirationDate
    }
    
    
    //  MARK: - Methods
    
    func exchangeCodeForToken(code: String, completion: @escaping ((Bool) -> Void)) {
        guard let url = URL(string: WetroConstants.tokenAPIURL) else { return }
        
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
        
        let basicToken = WetroConstants.clientID+":"+WetroConstants.clientSecret
        let data = basicToken.data(using: .utf8)
        guard let base64String = data?.base64EncodedString() else {
            completion(false)
            return
        }
        
        request.setValue("Basic \(base64String)", forHTTPHeaderField: "Authorization")
        
        let _ = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let self = self else { return }
            guard let data = data, error == nil else {
                completion(false)
                return
            }
            
            do {
                let jsonToken = try JSONDecoder().decode(WTToken.self, from: data)
                cacheToken(token: jsonToken)
                
                completion(true)
            } catch {
                print("DEBUG CONSOLE: \(error.localizedDescription)")
                completion(false)
            }
            
        }.resume()
    }
    
    func refreshToken(completion: @escaping(Bool) -> Void) {
        guard shouldRefreshToken else { 
            completion(true)
            return
        }
        
        //  MARK: Refreshing Request
        
        guard let url = URL(string: WetroConstants.tokenAPIURL) else { return }
        guard let refreshToken = PersistenceManager.retrieveRefreshToken() else { return }
        
        var urlComponents = URLComponents()
        urlComponents.queryItems = [
            URLQueryItem(name: "grant_type", value: "refresh_token"),
            URLQueryItem(name: "refresh_token", value: refreshToken),
        ]
        

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = urlComponents.query?.data(using: .utf8)
        
        let basicToken = WetroConstants.clientID+":"+WetroConstants.clientSecret
        let data = basicToken.data(using: .utf8)
        guard let base64String = data?.base64EncodedString() else {
            completion(false)
            return
        }
        request.setValue("Basic \(base64String)", forHTTPHeaderField: "Authorization")
        
        let _ = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let self = self else { return }
            guard let data = data, error == nil else {
                completion(false)
                return
            }
            do {
                let jsonToken = try JSONDecoder().decode(WTToken.self, from: data)
                cacheToken(token: jsonToken)
                
                completion(true)
            } catch {
                print("DEBUG CONSOLE: \(error.localizedDescription)")
                completion(false)
            }
        }.resume()
    }
    
    //  MARK: - Private Methods
    
    private func cacheToken(token: WTToken) {
        PersistenceManager.saveAccessToken(accessToken: token.accessToken)
        PersistenceManager.saveExpirationDateOfToken(expirationTime: token.expiresIn)
        if let refreshToken = token.refreshToken {
            PersistenceManager.saveRefreshToken(refreshToken: refreshToken)
        }
    }
}
