//
//  Constants.swift
//  Wetro
//
//  Created by Ислам Пулатов on 12/19/23.
//    pepwym-jenbIv-6zefvu

import Foundation
import UIKit.UIScreen

struct WTConstants {
    
    struct Identifiers {
        static let secondSectionViewCellIdentifier = "Second_Section_ViewCell_Identifier"
    }
    
    struct Keys {
        static let accessToken = "WETRO_ACCESS_TOKEN"
        static let refreshToken = "WETRO_REFRESH_TOKEN"
        static let expirationTime = "WETRO_EXPIRATION_TIME"
    }
    
    struct DeviceSizes {
        static let currentHeight = UIScreen.main.bounds.height
        static let currentWidth = UIScreen.main.bounds.width
    }
    
}
