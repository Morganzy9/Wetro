//
//  PersistenceActionType.swift
//  Wetro
//
//  Created by Ислам Пулатов on 12/19/23.
//

import Foundation

enum WTPersistenceActionType {
    case add, remove
}

enum WTPersistenceManager {
    static private let defaults = UserDefaults.standard
    
    static func retrieveAccessToken() -> String? {
        guard let data = defaults.object(forKey: WTConstants.Keys.accessToken) as? Data else { return nil }
        
        do {
            let decoder = JSONDecoder()
            let token = try decoder.decode(String.self, from: data)
            return token
        } catch {
            return nil
        }
    }
    
    static func retrieveRefreshToken() -> String? {
        guard let data = defaults.object(forKey: WTConstants.Keys.refreshToken) as? Data else { return nil }
        
        do {
            let decoder = JSONDecoder()
            let token = try decoder.decode(String.self, from: data)
            return token
        } catch {
            return nil
        }
    }
    
    static func retrieveExpirationDateOfToken() -> Date? {
        guard let data = defaults.object(forKey: WTConstants.Keys.expirationTime) as? Data else { return nil }
        
        do {
            let decoder = JSONDecoder()
            let token = try decoder.decode(Date.self, from: data)
            return token
        } catch {
            return nil
        }
    }
    
    static func saveAccessToken(accessToken: String) -> Void? {
        do {
            let encoder = JSONEncoder()
            let encodedAccessToken = try encoder.encode(accessToken)
            defaults.set(encodedAccessToken, forKey: WTConstants.Keys.accessToken)
            return nil
        } catch {
            return nil
        }
    }
    
    static func saveRefreshToken(refreshToken: String) -> Void? {
        do {
            let encoder = JSONEncoder()
            let encodedRefreshToken = try encoder.encode(refreshToken)
            defaults.set(encodedRefreshToken, forKey: WTConstants.Keys.refreshToken)
            return nil
        } catch {
            return nil
        }
    }
    
    static func saveExpirationDateOfToken(expirationTime: Int)-> Void? {
        do {
            let encoder = JSONEncoder()
            let encodedExpirationTime = try encoder.encode(Date().addingTimeInterval(TimeInterval(expirationTime)))
            defaults.set(encodedExpirationTime, forKey: WTConstants.Keys.expirationTime)
            return nil
        } catch {
            return nil
        }
    }
}
