//
//  OnBoardingVC.swift
//  Wetro
//
//  Created by Ислам Пулатов on 12/13/23.
//

import UIKit
import SnapKit

final class WTOnBoardingVC: UIViewController, Coordinating {
    
    //  MARK: - Constants & Variables
    
    var coordinator: Coordinator?
    
    //  MARK: - UI
    
    private let linkAccountView = WTOnBoardingView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewController()
    }
    
}

extension WTOnBoardingVC: LinkAccountViewDelegate {
    
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
        coordinator?.signWebViewPresentation()
    }
    
}
