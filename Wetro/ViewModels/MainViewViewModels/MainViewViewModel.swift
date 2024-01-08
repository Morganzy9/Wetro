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
