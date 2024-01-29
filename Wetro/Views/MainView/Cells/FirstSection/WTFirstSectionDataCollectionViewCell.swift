//
//  FirstSectionDataCollectionViewCell.swift
//  Wetro
//
//  Created by Ислам Пулатов on 1/9/24.
//

import UIKit
import Combine

class WTFirstSectionDataCollectionViewCell: UICollectionViewCell {
    
    //  MARK: - Properties
    
    private var cancellables = Set<AnyCancellable>()
    
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
        
        WTImageLoader.shared.downloadImagePublisher(viewModel.image)
            .receive(on: DispatchQueue.main)
            .sink { _ in }
            receiveValue: { [self] imageData in
                if let image = UIImage(data: imageData) {
                    songsImage.image = image
                } else {
                    print("Failed to create UIImage from downloaded data.")
                }
            }
            .store(in: &cancellables)
}

//  MARK: - Private Mathods

private func addSubViews() {
    addSubview(songsName)
    addSubview(artistname)
    addSubview(listenedAt)
    addSubview(songsImage)
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
    
    songsImage.snp.makeConstraints { make in
        make.top.equalTo(listenedAt.snp.bottom).offset(10)
        make.centerX.equalToSuperview()
        make.height.width.equalTo(50)
    }
}
}
