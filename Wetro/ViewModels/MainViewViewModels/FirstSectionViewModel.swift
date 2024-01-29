//
//  FirstSectionViewModel.swift
//  Wetro
//
//  Created by Ислам Пулатов on 1/28/24.
//

import Foundation
import Combine

protocol FirstSectionViewModelDelegate: AnyObject {
    func didFetchData()
}

final class FirstSectionViewModel {
    
    weak var delegate: FirstSectionViewModelDelegate?
    var cancellables: Set<AnyCancellable> = []
    var firstSectionData: [RecentlyPlayedSongs] = []
    
    func fetchListenedSongs() {
        
        WTAuthManager.shared.withValidAccessToken { [self] token in
            guard let token = token else { return }
            
            let pathComponenets = ["player", "recently-played"]
            let headers = ["Authorization": "Bearer \(token)"]
            let request = WTRequest(endPoint: .me,pathComponents: pathComponenets, headers: headers)
            
            WTService.shared.execute(request, expecting: RecentlySongsModel.self)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        print("Network request completed successfully.")
                    case .failure(let error):
                        print("Error this: \(error)")
                    }
                }, receiveValue: { response in
                    for song in response.items {
                        guard let artistName = song.track.artists.first?.name else { return }
                        guard let url = song.track.album.images.first?.url else { return }
                        guard let imageUrl = URL(string: url) else { return }
                       
                        let viewModel = RecentlyPlayedSongs(songName: song.track.name, playedAt: song.playedAt, artistName: artistName, image: imageUrl)
                        
                        let isElementExists = self.firstSectionData.contains { $0.songName == song.track.name && $0.artistName == artistName }
                        
                        if !isElementExists {
                            self.firstSectionData.append(viewModel)
                        }
                    }
                    self.delegate?.didFetchData()
                })
                .store(in: &cancellables)
        }
    }
    
}
