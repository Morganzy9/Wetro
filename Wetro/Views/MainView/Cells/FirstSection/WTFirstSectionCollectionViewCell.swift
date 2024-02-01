//
//  FirstSectionCollectionViewCell.swift
//  Wetro
//
//  Created by Ислам Пулатов on 1/9/24.
//

import UIKit

class WTFirstSectionCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    private var firstSectionCollectionView: UICollectionView!
    private let viewModel = FirstSectionViewModel()
    
    //  MARK: - UI
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        viewModel.fetchListenedSongs()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCollectionView()
    }
    
    // MARK: - Configuration
    
    func configure() {
        viewModel.delegate = self
        setupCollectionView()
        addSubViews()
        setConstraints()
        spinner.startAnimating()
    }
    
}

extension WTFirstSectionCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, FirstSectionViewModelDelegate {
    
    //  MARK: - Private Methods
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.sectionInset = .zero
        
        firstSectionCollectionView = UICollectionView(frame: bounds, collectionViewLayout: layout)
        firstSectionCollectionView.isPagingEnabled = true 
        firstSectionCollectionView.delegate = self
        firstSectionCollectionView.dataSource = self
        firstSectionCollectionView.register(WTFirstSectionDataCollectionViewCell.self, forCellWithReuseIdentifier: "SecondSectionCell")
        firstSectionCollectionView.backgroundColor = .clear
        firstSectionCollectionView.showsVerticalScrollIndicator = false
    }
    
    private func addSubViews() {
        addSubview(spinner)
        addSubview(firstSectionCollectionView)
    }
    
    private func setConstraints() {
        
        spinner.snp.makeConstraints { make in
            make.width.height.equalTo(100)
            make.centerX.centerY.equalToSuperview()
        }
        
        firstSectionCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.firstSectionData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SecondSectionCell", for: indexPath) as! WTFirstSectionDataCollectionViewCell
        cell.configure(with: viewModel.firstSectionData[indexPath.row])
        return cell
    }
    
    // UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
    
    //  MARK: - FirstSectionViewModelDelegate
    
    func didFetchData() {
        spinner.stopAnimating()
        firstSectionCollectionView.reloadData()
    }
    
    
}
