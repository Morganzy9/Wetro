//
//  ViewController.swift
//  Wetro
//
//  Created by Ислам Пулатов on 12/13/23.
//

import UIKit
import SnapKit

final class SingViewController: UIViewController, Coordinating {
    
    var coordinator: Coordinator?
    
    //  MARK: - UI
    
    private lazy var signInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign In", for: .normal)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(signInButtonPressed), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewController()
    }

}

extension SingViewController {
    
    //  MARK: - Private Methods
    
    private func setViewController() {
        setAperance()
        addViewSubViews()
        setUIConstrains()
    }
    
    private func setAperance() {
        title = "LOLOLO"
        view.backgroundColor = .systemRed
    }
    
    private func addViewSubViews() {
        view.addSubview(signInButton)
    }
    
    private func setUIConstrains() {
        signInButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(200)
        }
    }
    
    //  MARK: - Private @objc Methods
    @objc
    func signInButtonPressed() {
        print("DEBUG CONSOLE: ")
        coordinator?.signSuccess()
    }
}

