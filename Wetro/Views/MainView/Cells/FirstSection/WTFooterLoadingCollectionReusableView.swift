//
//  WTFooterLoadingCollectionReusableView.swift
//  Wetro
//
//  Created by Ислам Пулатов on 2/5/24.
//

import UIKit
import SnapKit

final class WTFooterLoadingCollectionReusableView: UICollectionReusableView {
 
    //  MARK: - UI
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.color = WTAppearance.secondTint
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
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

extension WTFooterLoadingCollectionReusableView {
    
    //  MARK: - Methods
    
    func startAnimating() {
        spinner.startAnimating()
    }
    
    //  MARK: - Private Methods
    
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
 
