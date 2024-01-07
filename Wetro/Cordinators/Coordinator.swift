//
//  Coordinator.swift
//  Wetro
//
//  Created by Ислам Пулатов on 12/14/23.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController? { get set }
    func signSuccess()
    func start()
    func signWebViewPresentation()
}

protocol Coordinating {
    var coordinator: Coordinator? { get set }
}
