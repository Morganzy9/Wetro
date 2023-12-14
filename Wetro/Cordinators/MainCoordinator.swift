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
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func start() {
        var vc: UIViewController & Coordinating = SingViewController()
        vc.coordinator = self
        navigationController?.setViewControllers([vc], animated: false)
        navigationController?.navigationBar.isHidden = true
    }

}
