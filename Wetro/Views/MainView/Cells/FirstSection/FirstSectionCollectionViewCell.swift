//
//  FirstSectionCollectionViewCell.swift
//  Wetro
//
//  Created by Ислам Пулатов on 1/9/24.
//

import UIKit

class FirstSectionCollectionViewCell: UICollectionViewCell {
    
    
    // MARK: - Properties
    
    private var firstSectionCollectionView: UICollectionView!
    
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

extension FirstSectionCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //  MARK: - Private Methods
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        firstSectionCollectionView = UICollectionView(frame: bounds, collectionViewLayout: layout)
        firstSectionCollectionView.delegate = self
        firstSectionCollectionView.dataSource = self
        firstSectionCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "SecondSectionCell")
        firstSectionCollectionView.backgroundColor = .clear
        firstSectionCollectionView.showsVerticalScrollIndicator = false
    }
    
    private func addSubViews() {
        addSubview(firstSectionCollectionView)
    }
    
    private func setConstrains() {
        firstSectionCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SecondSectionCell", for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }

}
