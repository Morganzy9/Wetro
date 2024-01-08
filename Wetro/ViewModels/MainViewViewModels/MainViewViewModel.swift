//
//  MainViewViewModel.swift
//  Wetro
//
//  Created by Ислам Пулатов on 1/8/24.
//

import UIKit

final class MainViewViewModel: NSObject ,UICollectionViewDelegate, UICollectionViewDataSource {
    
    enum SectionType: CaseIterable {
        case firstSectionMain
        case secondSectionMain
        case thirdSectionMain
    }
    
    let sections = SectionType.allCases
    
    //  MARK: - Public Methods
    
    func setSections(for sectionIndex: Int) -> NSCollectionLayoutSection{
        switch sections[sectionIndex] {
        case .firstSectionMain:
            return createFirstSectionLayout()
        case .secondSectionMain:
            return createSecondSectionLayout()
        case .thirdSectionMain:
            return createThirdSectionLayout()
        }
    }

    //  MARK: - Private Methods
    
    //  MARK: Sections in MainView
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
    
    //  MARK: - MainlCollectionView: MainCollUICollectionViewDelegate, UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch sections[indexPath.section] {
        case .firstSectionMain:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NUMERONE", for: indexPath)
            cell.backgroundColor = .systemCyan
            return cell
        case .secondSectionMain:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NUMERONE", for: indexPath)
            cell.backgroundColor = .systemRed
            return cell
        case .thirdSectionMain:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NUMERONE", for: indexPath)
            cell.backgroundColor = .systemTeal
            return cell
        }
    }
    
}
