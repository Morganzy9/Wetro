//
//  SecondSectionCollectionViewCell.swift
//  Wetro
//
//  Created by Ислам Пулатов on 1/8/24.
//

import UIKit

class WTSecondSectionCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    private var secondSectionCollectionView: UICollectionView!
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCollectionView()
    }
    
    // MARK: - Configuration
    
    func configure() {
        setupCollectionView()
        addSubViews()
        setConstrains()
    }
    
    
}

extension WTSecondSectionCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //  MARK: - Private Methods
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        secondSectionCollectionView = UICollectionView(frame: bounds, collectionViewLayout: layout)
        secondSectionCollectionView.delegate = self
        secondSectionCollectionView.dataSource = self
        secondSectionCollectionView.register(WTSecondSectionDataCollectionViewCell.self, forCellWithReuseIdentifier: "SecondSectionCell")
        secondSectionCollectionView.backgroundColor = .clear
        secondSectionCollectionView.showsHorizontalScrollIndicator = false
    }
    
    private func addSubViews() {
        addSubview(secondSectionCollectionView)
    }
    
    private func setConstrains() {
        secondSectionCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SecondSectionCell", for: indexPath) as! WTSecondSectionDataCollectionViewCell
        cell.configure(with: "HERE IT IS")
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
}
