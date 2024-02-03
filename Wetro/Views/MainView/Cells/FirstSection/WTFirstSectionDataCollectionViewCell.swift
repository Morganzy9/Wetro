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
    private let imageLoader = WTImageLoader.shared
    
    //  MARK: - UI
    
    private let songsName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = WTAppearance.secodaryBackGround
        label.font = .poppinsSemiBoldItalic(of: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let artistname: UILabel = {
        let label = UILabel()
        label.textColor = WTAppearance.secodaryBackGround
        label.font = .poppinsSemiBold(of: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let listenedAt: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.backgroundColor = .white
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let songsImageContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor.white.cgColor
        view.layer.shadowOpacity = 0.8
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.shadowRadius = 5
        view.layer.masksToBounds = false
        return view
    }()
    
    private let songsImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        return image
    }()
    
    
    //  MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = WTAppearance.firstTint
        layer.cornerRadius = 20
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension WTFirstSectionDataCollectionViewCell {
    
    //  MARK: - Methods
    
    func configure(with viewModel: RecentlyPlayedSongs) {
        songsName.text = viewModel.songName
        artistname.text = viewModel.artistName
        listenedAt.text = viewModel.playedAt
        
        imageLoader.downloadImagePublisher(viewModel.image)
            .receive(on: DispatchQueue.main)
            .sink { _ in
            } receiveValue: { [self] imageData in
                if let image = UIImage(data: imageData) {
                    songsImage.image = image
                } else {
                    print("Failed to create UIImage from downloaded data.")
                }
            }
            .store(in: &cancellables)
        
        setCell()
    }
    
    private func setCell() {
        addSubViews()
        setContrains()
    }
    
    //  MARK: - Private Mathods
    
    private func addSubViews() {
        addSubview(songsName)
        addSubview(artistname)
        addSubview(listenedAt)
        addSubview(songsImageContainer)
        songsImageContainer.addSubview(songsImage)
    }
    
    private func setContrains() {
        
        songsImageContainer.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(bounds.width / 6)
            make.centerY.equalToSuperview()
            make.height.equalToSuperview().dividedBy(2.5)
            make.width.equalToSuperview().dividedBy(4)
        }
        
        songsImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        songsName.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(bounds.height / 3)
            make.leading.equalTo(songsImage.snp.trailing).offset(10)
            make.trailing.equalToSuperview()
            make.height.equalTo(25)
        }
        
        artistname.snp.makeConstraints { make in
            make.top.equalTo(songsName.snp.bottom).offset(10)
            make.leading.equalTo(songsImage.snp.trailing).offset(10)
        }
        
        listenedAt.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10 )
            make.trailing.equalToSuperview().offset(-10)
        }
        
    }
}
