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
        setConstraints()
    }
    
}

extension FirstSectionCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //  MARK: - Private Methods
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0 // Set to zero for no spacing between cells
        layout.minimumInteritemSpacing = 0 // Set to zero for no spacing between cells
        layout.sectionInset = .zero
        layout.itemSize = CGSize(width: bounds.width, height: bounds.height) // Cell size matches the collection view bounds
        
        firstSectionCollectionView = UICollectionView(frame: bounds, collectionViewLayout: layout)
        firstSectionCollectionView.isPagingEnabled = true // Enable paging to snap cells to the center
        firstSectionCollectionView.delegate = self
        firstSectionCollectionView.dataSource = self
        firstSectionCollectionView.register(FirstSectionDataCollectionViewCell.self, forCellWithReuseIdentifier: "SecondSectionCell")
        firstSectionCollectionView.backgroundColor = .clear
        firstSectionCollectionView.showsVerticalScrollIndicator = false
    }
    
    private func addSubViews() {
        addSubview(firstSectionCollectionView)
    }
    
    private func setConstraints() {
        firstSectionCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10 // Replace this with the actual number of items you have
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SecondSectionCell", for: indexPath) as! FirstSectionDataCollectionViewCell
        cell.backgroundColor = .red
        cell.configure(with: "ONLY YOU")
        return cell
    }
    
    // UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
}
