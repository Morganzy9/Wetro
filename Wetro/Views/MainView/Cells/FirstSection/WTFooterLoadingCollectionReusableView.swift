//
//  WTFooterLoadingCollectionReusableView.swift
//  Wetro
//
//  Created by Ислам Пулатов on 2/5/24.
//

import UIKit
import SnapKit

class WTFooterLoadingCollectionReusableView: UICollectionReusableView {
 
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.color = WTAppearance.secondTint
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension WTFooterLoadingCollectionReusableView {
    
    func startAnimating() {
        spinner.startAnimating()
    }
    
    private func setView() {
        addSubViews()
        setConstrains()
    }
    
    private func addSubViews() {
        addSubview(spinner)
    }
    
    private func setConstrains() {
        spinner.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
}
 
