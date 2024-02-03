//
//  WTFirstSectionHeaderView.swift
//  Wetro
//
//  Created by Ислам Пулатов on 2/3/24.
//

import UIKit

class WTFirstSectionHeaderView: UICollectionReusableView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Your recently Listened Songs"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = WTAppearance.firstTint
        label.font = .poppinsSemiBoldItalic(of: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension WTFirstSectionHeaderView {
    
    private func setView() {
        addSubViews()
        setViewConstrains()
    }
    
    private func addSubViews() {
        addSubview(titleLabel)
    }
    
    private func setViewConstrains() {
        
        titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
}
