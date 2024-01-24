//
//  MainCoordinator.swift
//  Wetro
//
//  Created by Ислам Пулатов on 12/14/23.
//

import UIKit

final class MainCoordinator: Coordinator {
    
    var navigationController: UINavigationController?
    
    func start() {
        if WTAuthManager.shared.isSignedIn {
            let vc = WTTabBarController()
            vc.coordinator = self
            vc.title = "MainVC"
            navigationController?.setViewControllers([vc], animated: false)
        } else {
            let vc = WTOnBoardingVC()
            vc.coordinator = self
            navigationController?.setViewControllers([vc], animated: false)
            navigationController?.navigationBar.isHidden = false
        }
    }
    
    func signSuccess() {
        navigationController?.dismiss(animated: true)
        let vc = WTTabBarController()
        vc.coordinator = self
        
        let transition = CATransition()
        transition.duration = 0.2
        transition.type = .fade
        navigationController?.view.layer.add(transition, forKey: kCATransition)
        navigationController?.setViewControllers([vc], animated: false)
        navigationController?.navigationBar.isHidden = false
    }
    
    
    func signWebViewPresentation() {
        let vc = WTSignInController()
        vc.coordinator = self
        navigationController?.navigationBar.tintColor = .systemGreen
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
