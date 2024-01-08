//
//  MainView.swift
//  Wetro
//
//  Created by Ислам Пулатов on 1/8/24.
//

import UIKit
import SnapKit

final class MainView: UIView {
    
    //  MARK: - Variables & Constants
    
    private let viewModel = MainViewViewModel()
    
    //  MARK: - UI
    
    private var mainlCollectionView: UICollectionView?
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
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

extension MainView {
    
    //  MARK: - Private Methods
    
    private func setView() {
        setAppearance()
        setupCollectionView()
        addSubViews()
        setDelegates()
        setConstrains()
    }
    
    private func setAppearance() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
    }
    
    private func addSubViews() {
        guard let mainlCollectionView = mainlCollectionView else { return }
        addSubview(spinner)
        addSubview(mainlCollectionView)
    }
    
    private func setConstrains() {
        guard let mainlCollectionView = mainlCollectionView else { return }
        
        spinner.snp.makeConstraints { make in
            make.width.height.equalTo(100)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        mainlCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setDelegates() {
        guard let mainlCollectionView = mainlCollectionView else { return }
        mainlCollectionView.delegate = viewModel
        mainlCollectionView.dataSource = viewModel
    }
    
    private func setupCollectionView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
        let collectionView = createMainCollectionView()
        mainlCollectionView = collectionView
    }
    
    private func createMainCollectionView() -> UICollectionView {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            return self.createSection(for: sectionIndex)
        }
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "NUMERONE")
        return collectionView
    }
    
    private func createSection(for sectionIndex: Int) -> NSCollectionLayoutSection {
        switch viewModel.sections[sectionIndex] {
        case .firstSectionMain:
            createFirstSectionLayout()
        case .secondSectionMain:
            createSecondSectionLayout()
        case .thirdSectionMain:
            createThirdSectionLayout()
        }
    }
    
    private func createFirstSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                             heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                                        heightDimension: .absolute(150)),
                                                     subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    private func createSecondSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                             heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                                        heightDimension: .absolute(150)),
                                                     subitems: [item, item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
    
    private func createThirdSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                             heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                                        heightDimension: .absolute(150)),
                                                     subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
}
