//
//  MainViewViewModel.swift
//  Wetro
//
//  Created by Ислам Пулатов on 1/8/24.
//

import UIKit
import Combine

final class WTMainViewViewModel: NSObject ,UICollectionViewDelegate, UICollectionViewDataSource{
    
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
            return createLayoutSection(with: 250, contentInsets: NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10), header: true)
        case .secondSectionMain:
            return createLayoutSection(with: 300, contentInsets: NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10), isPagingEnabled: true, header: false)
        case .thirdSectionMain:
            return createLayoutSection(with: 150, contentInsets: NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0), header: false)
        }
    }
    
    //  MARK: - Private Methods
    
    //  MARK: Creating Sections in MainView
    
    private func createLayoutSection(with itemHeight: CGFloat, contentInsets: NSDirectionalEdgeInsets, isPagingEnabled: Bool = false, isHorizontal: Bool = false, header: Bool) -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                             heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = contentInsets
        
        let group: NSCollectionLayoutGroup
        if isHorizontal {
            group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                                          heightDimension: .absolute(itemHeight)),
                                                       repeatingSubitem: item,
                                                       count: 2)
        } else {
            group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                                        heightDimension: .absolute(itemHeight)),
                                                     repeatingSubitem: item,
                                                     count: 1)
        }
        
        let section = NSCollectionLayoutSection(group: group)
        
        if isPagingEnabled {
            section.orthogonalScrollingBehavior = .groupPaging
        }
        
        if header {
            section.boundarySupplementaryItems = [
                .init(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
            ]
        }
        
        return section
    }
    
    
    //  MARK: - MainlCollectionView: MainCollUICollectionViewDelegate, UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch sections[section] {
        case .firstSectionMain:
            return 1
        case .secondSectionMain:
            return 1
        case .thirdSectionMain:
            return 3
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch sections[indexPath.section] {
        case .firstSectionMain:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WTConstants.Identifiers.firstSectionViewCellIdentifier, for: indexPath)
            return cell
        case .secondSectionMain:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WTConstants.Identifiers.secondSectionViewCellIdentifier, for: indexPath)
            return cell
        case .thirdSectionMain:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NUMERONE", for: indexPath)
            cell.backgroundColor = .systemTeal
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {
            fatalError("Unexpected kind of supplementary view")
        }
        
        // Dequeue a reusable header view
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderViewIdentifier", for: indexPath) as! WTFirstSectionHeaderView
        
        // Configure the header view
        //        headerView.titleLabel.text = "Section Header Title" // Set your header title here
        
        return headerView
    }
    
    
}
