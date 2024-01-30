//
//  UIFont.swift
//  Wetro
//
//  Created by Ислам Пулатов on 1/30/24.
//

import UIKit.UIFont

extension UIFont {
    
    static func delaGothic(of size: CGFloat) -> UIFont? {
        return UIFont(name: "DelaGothicOne-Regular", size: size)
    }
    
    static func poppinsSemiBold(of size: CGFloat) -> UIFont? {
        return UIFont(name: "Poppins-SemiBold", size: size)
    }
    
    static func poppinsSemiBoldItalic(of size: CGFloat) -> UIFont? {
        return UIFont(name: "Poppins-SemiBoldItalic", size: size)
    }
    
}
