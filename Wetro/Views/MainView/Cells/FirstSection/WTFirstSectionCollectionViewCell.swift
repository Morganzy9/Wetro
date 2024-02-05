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
    
    private var shouldShowFooterLoadIndicator = false
    private var isLoadingMoreData = false
    
    //  MARK: - UI
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.color = WTAppearance.secondTint
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

extension WTFirstSectionCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, FirstSectionViewModelDelegate, UIScrollViewDelegate {
    
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
        firstSectionCollectionView.register(WTFirstSectionDataCollectionViewCell.self, forCellWithReuseIdentifier: WTConstants.Identifiers.firstSectionCellIdentifier)
        firstSectionCollectionView.register(WTFooterLoadingCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: WTConstants.Identifiers.firstSectionFooterLoadingCollectionReusableView)
        firstSectionCollectionView.backgroundColor = .clear
        firstSectionCollectionView.showsVerticalScrollIndicator = false
    }
    
    private func addSubViews() {
        addSubview(spinner)
        addSubview(firstSectionCollectionView)
    }
    
    private func setConstraints() {
        
        spinner.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        firstSectionCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.firstSectionData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WTConstants.Identifiers.firstSectionCellIdentifier, for: indexPath) as! WTFirstSectionDataCollectionViewCell
        cell.configure(with: viewModel.firstSectionData[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard kind == UICollectionView.elementKindSectionFooter, shouldShowFooterLoadIndicator,
              let footer = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: WTConstants.Identifiers.firstSectionFooterLoadingCollectionReusableView,
                for: indexPath) as? WTFooterLoadingCollectionReusableView else {
            fatalError("Error with dequeeu the footer reusable view")
        }
         
        footer.startAnimating()
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        guard shouldShowFooterLoadIndicator else { return .zero}
        return CGSize(width: collectionView.frame.width, height: 100)
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height - 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    //  MARK: - FirstSectionViewModelDelegate
    
    func didFetchData() {
        spinner.stopAnimating()
        firstSectionCollectionView.reloadData()
        shouldShowFooterLoadIndicator = true
    }
    
    //  MARK: - UIScrollViewDelegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard shouldShowFooterLoadIndicator, !isLoadingMoreData else { return }
        
        let offSet = scrollView.contentOffset.y
        let totalContentHeight = scrollView.contentSize.height
        let totalScrollViewFixedHeight = scrollView.frame.size.height
        
        if offSet >= (totalContentHeight - totalScrollViewFixedHeight - 120) {
            isLoadingMoreData = true
        }
    }
    
}
