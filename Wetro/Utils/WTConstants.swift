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
        
        //  MARK: - MainVC
        
        //  MARK: Compositional LayOut Cells
        
        static let firstSectionViewCellIdentifier = "First_Section_ViewCell_Identifier"
        static let secondSectionViewCellIdentifier = "Second_Section_ViewCell_Identifier"
        
        //  MARK: Sections Cell Identifiers
        
        static let firstSectionCellIdentifier = "First_Section_Cell_Identifier"
        static let secondSectionCellIdentifier = "Second_Section_Cell_Identifier"
            
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
