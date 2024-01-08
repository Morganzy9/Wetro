//
//  ViewController.swift
//  Wetro
//
//  Created by Ислам Пулатов on 1/7/24.
//

import UIKit
import SnapKit

class MainVC: UIViewController {
    
    private let mainView = MainView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setController()
    }

}

extension MainVC {
    
    //  MARK: - Private Methods
    
    private func setController() {
        setAppearance()
        addSubViews()
        setConstrains()
        setDelegates()
    }
    
    private func setAppearance() {
        view.backgroundColor = .systemBackground
    }
    
    private func addSubViews() {
        view.addSubview(mainView)
    }
    
    private func setConstrains() {
        mainView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(10)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setDelegates() {
        
    }
}
