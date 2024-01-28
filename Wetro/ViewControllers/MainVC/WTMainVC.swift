//
//  ViewController.swift
//  Wetro
//
//  Created by Ислам Пулатов on 1/7/24.
//

import UIKit
import SnapKit

final class WTMainVC: UIViewController {
    
    private let mainView = WTMainView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setController()
    }
    
}

extension WTMainVC {
    
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
            if (tabBarController?.tabBar.frame.height) != nil {
                make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-15)
            }
        }
        
        
    }
    
    private func setDelegates() {
        
    }
}
