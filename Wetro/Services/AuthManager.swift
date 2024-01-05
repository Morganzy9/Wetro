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
    }
    
    var signInURL: URL? {
        let base = "https://accounts.spotify.com/authorize"
        let redirectURI = "https%3A%2F%2Fwww.google.com%2F"
        let scope = "user-top-read,user-read-playback-state,user-modify-playback-state,playlist-read-private,playlist-read-collaborative"
        let signUrl = "\(base)?client_id=\(Constants.clientID)&response_type=code&redirect_uri=\(redirectURI)&scope=\(scope)&show_dialog=TRUE"
        return URL(string: signUrl)
    }
    
    
    
}
