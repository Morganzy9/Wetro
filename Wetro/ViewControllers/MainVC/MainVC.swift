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
        if let scrollView = mainView.subviews.compactMap({ $0 as? UIScrollView }).first {
            if #available(iOS 11.0, *) {
                scrollView.contentInsetAdjustmentBehavior = .never
            } else {
                automaticallyAdjustsScrollViewInsets = false
            }
        }
        
        view.backgroundColor = .systemBackground
    }
    
    private func addSubViews() {
        view.addSubview(mainView)
    }
    
    private func setConstrains() {
        let topOffset = navigationController?.navigationBar.frame.height ?? 0
        
        mainView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(topOffset)
            make.leading.trailing.equalToSuperview()
            if let tabBarHeight = tabBarController?.tabBar.frame.height {
                make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-15)
            }
        }
        
        
    }
    
    private func setDelegates() {
        
    }
}
