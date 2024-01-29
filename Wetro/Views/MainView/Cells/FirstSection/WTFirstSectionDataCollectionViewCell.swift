//
//  FirstSectionDataCollectionViewCell.swift
//  Wetro
//
//  Created by Ислам Пулатов on 1/9/24.
//

import UIKit

class WTFirstSectionDataCollectionViewCell: UICollectionViewCell {
    //  MARK: - UI
    
    private let songsName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let artistname: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let listenedAt: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let songsImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    //  MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setCell()
        backgroundColor = .blue
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension WTFirstSectionDataCollectionViewCell {
    
    //  MARK: - Methods
    
    func setCell() {
        addSubViews()
        setContrains()
    }
    
    func configure(with viewModel: RecentlyPlayedSongs) {
        songsName.text = viewModel.songName
        artistname.text = viewModel.artistName
        listenedAt.text = viewModel.playedAt
        
        WTImageLoader.shared.downloadImage(viewModel.image) { success in
            switch success {
            case .success(let success):
                print("DEBUG CONSOLE: Success")
            case .failure(let failure):
                print("DEBUG CONSOLE: \(failure.localizedDescription)")
            }
        }
    }
    
    //  MARK: - Private Mathods
    
    private func addSubViews() {
        addSubview(songsName)
        addSubview(artistname)
        addSubview(listenedAt)
    }
    
    private func setContrains() {
        songsName.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        artistname.snp.makeConstraints { make in
            make.top.equalTo(songsName.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        listenedAt.snp.makeConstraints { make in
            make.top.equalTo(artistname.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            
        }
    }
}
