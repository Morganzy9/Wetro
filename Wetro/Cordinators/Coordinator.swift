//
//  Coordinator.swift
//  Wetro
//
//  Created by Ислам Пулатов on 12/14/23.
//

import UIKit
import SafariServices

protocol Coordinator {
    var navigationController: UINavigationController? { get set }
    func signSuccess()
    func start()
    func safariLinkPresentation(vc: SFSafariViewController)
}

protocol Coordinating {
    var coordinator: Coordinator? { get set }
}
