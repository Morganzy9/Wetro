//
//  MainView.swift
//  Wetro
//
//  Created by Ислам Пулатов on 1/8/24.
//

import UIKit
import SnapKit

final class WTMainView: UIView {
    
    //  MARK: - Variables & Constants
    
    private let viewModel = WTMainViewViewModel()
    
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
        WTAuthManager.shared.refreshToken { success in
            if success {
                print("DEBUG CONSOLE: Success")
            } else {
                print("DEBUG CONSOLE: NO")
            }
        }
        viewModel.fetchListenedSongs()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension WTMainView {
    
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
            make.centerX.centerY.equalToSuperview()
        }
        
        mainlCollectionView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
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
        collectionView.showsVerticalScrollIndicator = false
        mainlCollectionView = collectionView
    }
    
    private func createMainCollectionView() -> UICollectionView {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            return self.createSection(for: sectionIndex)
        }
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "NUMERONE")
        collectionView.register(WTFirstSectionCollectionViewCell.self, forCellWithReuseIdentifier: WTConstants.Identifiers.firstSectionViewCellIdentifier)
        collectionView.register(WTSecondSectionCollectionViewCell.self, forCellWithReuseIdentifier: WTConstants.Identifiers.secondSectionViewCellIdentifier)
        return collectionView
    }
    
    private func createSection(for sectionIndex: Int) -> NSCollectionLayoutSection {
        viewModel.setSections(for: sectionIndex)
    }
}
