//
//  LinkAccountVCViewModel.swift
//  Wetro
//
//  Created by Ислам Пулатов on 12/19/23.
//

import UIKit
import SafariServices

final class LinkAccountVCViewModel {
    
    
    
}


extension LinkAccountVC: SFSafariViewControllerDelegate {
    
    func safariViewController(_ controller: SFSafariViewController, initialLoadDidRedirectTo URL: URL) {
        let currentURL = URL.absoluteURL
        print("DEBUG CONSOLE: \(currentURL)")
        guard currentURL.absoluteString.contains("https://www.google.com/?code=") else { return }
    }
}
