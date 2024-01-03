//
//  LinkAccountVC.swift
//  Wetro
//
//  Created by Ислам Пулатов on 12/13/23.
//

import UIKit
import SnapKit
import SafariServices

final class LinkAccountVC: UIViewController, Coordinating {
    
    //  MARK: - Constants & Variables
    
    var coordinator: Coordinator?
    private let viewModel = LinkAccountVCViewModel()
    
    //  MARK: - UI
    
    private let linkAccountView = LinkAccountView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewController()
    }
}

extension LinkAccountVC: LinkAccountViewDelegate, SFSafariViewControllerDelegate {
    
    //  MARK: - Private Methods
    
    private func setViewController() {
        setAperance()
        setDelegates()
        addViewSubViews()
        setConstrains()
    }
    
    private func setAperance() {
        title = "Link Account"
        view.backgroundColor = .systemBackground
    }
    
    private func setDelegates() {
        linkAccountView.delegate = self
    }
    
    private func addViewSubViews() {
        view.addSubview(linkAccountView)
    }
    
    private func setConstrains() {
        linkAccountView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    //  MARK: - LinkAccountViewDelegate
    
    func didTapLinkAccountButton() {
        guard let url = URL(string: "https://accounts.spotify.com/authorize?client_id=11e9a62378e2443fb80a41efadfee150&response_type=code&redirect_uri=https%3A%2F%2Fwww.google.com%2F&scope=user-top-read,user-read-playback-state,user-modify-playback-state,playlist-read-private,playlist-read-collaborative") else { return }
        let safari = SFSafariViewController(url: url)
        safari.delegate = self
        safari.preferredBarTintColor = .black
        safari.preferredControlTintColor = .systemGreen
        
        coordinator?.safariLinkPresentation(vc: safari)
    }
    
    //  MARK: - SFSafariViewControllerDelegate
    
    func safariViewController(_ controller: SFSafariViewController, initialLoadDidRedirectTo URL: URL) {
        let currentURL = URL.absoluteURL
        print("DEBUG CONSOLE 1- : \(currentURL)")
        guard currentURL.absoluteString.contains("https://www.google.com/?code=") else { return }
        viewModel.authorizeUser(with: currentURL.absoluteString)
        print("DEBUG CONSOLE 2- : \(currentURL)")
        coordinator?.closeSafari()
    }
    
}
