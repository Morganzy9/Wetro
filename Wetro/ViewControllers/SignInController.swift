//
//  DataViewController.swift
//  Wetro
//
//  Created by Ислам Пулатов on 12/14/23.
//

import UIKit
import SnapKit
import WebKit

class SignInController: UIViewController, Coordinating {
    var coordinator: Coordinator?

    //  MARK: - UI
    
    private let signWebView: WKWebView = {
        let prefWebView = WKWebpagePreferences()
        prefWebView.allowsContentJavaScript = true
        let configWebView = WKWebViewConfiguration()
        configWebView.defaultWebpagePreferences = prefWebView
        let webView = WKWebView(frame: .zero, configuration: configWebView)
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewController()
    }

}

extension SignInController: WKNavigationDelegate {
    
    //  MARK: - Private methods
    
    private func setViewController() {
        setAppearance()
        setSignWebView()
    }
    
    private func setAppearance() {
        title = "Success"
        view.backgroundColor = .systemBackground
    }
    
    private func setSignWebView() {
        signWebView.navigationDelegate = self
        view.addSubview(signWebView)
        
        signWebView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        guard let authUrl = AuthManager.shared.signInURL else { return }
        signWebView.load(URLRequest(url: authUrl))
    }

    
    //  MARK: - Extension - WKNavigationDelegate
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        guard let url = webView.url else { return }
        
        //        Gettin access token
        let component = URLComponents(string: url.absoluteString)
        guard let code = component?.queryItems?.first(where: { $0.name == "code" })?.value else { return }
        signWebView.isHidden = true
        print("DEBUG CONSOLE: \(code)")
        
        AuthManager.shared.exchangeCodeForToken(code: code) { [weak self] success in
            DispatchQueue.main.async {
                
            }
        }
        
    }
    
}
