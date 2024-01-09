//
//  FirstSectionDataCollectionViewCell.swift
//  Wetro
//
//  Created by Ислам Пулатов on 1/9/24.
//

import UIKit

class FirstSectionDataCollectionViewCell: UICollectionViewCell {
    //  MARK: - UI
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    //  MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setCell()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension FirstSectionDataCollectionViewCell {
    
    //  MARK: - Methods
    
    func setCell() {
        addSubViews()
        setContrains()
    }
    
    func configure(with text: String) {
        titleLabel.text = text
    }
    
    //  MARK: - Private Mathods
    
    private func addSubViews() {
        addSubview(titleLabel)
    }
    
    private func setContrains() {
        titleLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
}
