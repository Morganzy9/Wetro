//
//  MainCoordinator.swift
//  Wetro
//
//  Created by Ислам Пулатов on 12/14/23.
//

import UIKit

final class MainCoordinator: Coordinator {
    
    var navigationController: UINavigationController?
    
    func signSuccess() {
        let vc = DataViewController()
        vc.coordinator = self
        
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = .fade
        navigationController?.view.layer.add(transition, forKey: kCATransition)
        navigationController?.setViewControllers([vc], animated: false)
    }

    
    func start() {
        let vc = SingViewController()
        vc.coordinator = self
        navigationController?.setViewControllers([vc], animated: false)
        navigationController?.navigationBar.isHidden = false
    }


}
