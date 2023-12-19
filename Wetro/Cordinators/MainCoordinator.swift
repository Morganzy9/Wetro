//
//  MainCoordinator.swift
//  Wetro
//
//  Created by Ислам Пулатов on 12/14/23.
//

import UIKit
import SafariServices

final class MainCoordinator: Coordinator {
    
    var navigationController: UINavigationController?
    
    func start() {
        let vc = LinkAccountVC()
        vc.coordinator = self
        navigationController?.setViewControllers([vc], animated: false)
        navigationController?.navigationBar.isHidden = false
    }
    
    func signSuccess() {
        let vc = DataViewController()
        vc.coordinator = self
        
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = .fade
        navigationController?.view.layer.add(transition, forKey: kCATransition)
        navigationController?.setViewControllers([vc], animated: false)
    }
    
    func safariLinkPresentation(vc: SFSafariViewController) {
        navigationController?.present(vc, animated: true)
    }
    
    func closeSafari() {
        navigationController?.popViewController(animated: true)
    }
    
}
