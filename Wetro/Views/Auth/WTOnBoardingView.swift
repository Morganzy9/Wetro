//
//  OnBoardingView.swift
//  Wetro
//
//  Created by Ислам Пулатов on 12/19/23.
//

import UIKit
import SafariServices

protocol LinkAccountViewDelegate: AnyObject {
    func didTapLinkAccountButton()
}

class WTOnBoardingView: UIView, Coordinating{
    
    var coordinator: Coordinator?
    weak var delegate: LinkAccountViewDelegate?
    
    //  MARK: - Private
    
    
    //  MARK: - UI
    
    private lazy var signInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign In", for: .normal)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(signInButtonPressed), for: .touchUpInside)
        return button
    }()
    
    //  MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension WTOnBoardingView {
    
    //  MARK: - Private Methods
    
    private func setView() {
        setAppearance()
        addSubViews()
        setConstrains()
    }
    
    private func setAppearance() {
    }
    
    private func addSubViews() {
        addSubview(signInButton)
    }
    
    private func setConstrains() {
        signInButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(200)
        }
    }
    
    //  MARK: - @objc Methods
    
    @objc func signInButtonPressed() {
        delegate?.didTapLinkAccountButton()
    }
    
}
