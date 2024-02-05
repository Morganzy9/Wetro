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
    var before: String?
    
    func fetchListenedSongs() {
        
        WTAuthManager.shared.withValidAccessToken { [self] token in
            guard let token = token else { return }
            
            let pathComponenets = ["player", "recently-played"]
            let headers = ["Authorization": "Bearer \(token)"]
            let params: [URLQueryItem] = [
            
                URLQueryItem(name: "limit", value: "2")
            
            ]
            let request = WTRequest(endPoint: .me, pathComponents: pathComponenets, queryParameters: params ,headers: headers)
            
            WTService.shared.execute(request, expecting: RecentlySongsModel.self)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished: break
                    case .failure(let error):
                        print("Error this: \(error)")
                    }
                }, receiveValue: { response in
                    self.before = response.cursors.before
                    
                    for song in response.items {
                        
                        let songsName = self.truncateSongName(song.track.name)
                        guard let artistName = song.track.artists.first?.name else { return }
                        guard let url = song.track.album.images.first?.url else { return }
                        guard let imageUrl = URL(string: url) else { return }
                        guard let playedAt = self.formatDate(song.playedAt) else { return }
                       
                        let viewModel = RecentlyPlayedSongs(songName: songsName, playedAt: playedAt, artistName: artistName, image: imageUrl)
                        
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
    
    func fetchAdditionalsListenedSongs(before: String?) {
        guard let before = before else { return }
        print("DEBUG CONSOLE: \(before)")
        
        WTAuthManager.shared.withValidAccessToken { [weak self] token in
            guard let self = self, let token = token else { return }
            
            let pathComponents = ["player", "recently-played"]
            let headers = ["Authorization": "Bearer \(token)"]
            let params: [URLQueryItem] = [
                URLQueryItem(name: "limit", value: "50"),
                URLQueryItem(name: "before", value: before)
            ]
            
            let request = WTRequest(endPoint: .me, pathComponents: pathComponents, queryParameters: params, headers: headers)
            
            WTService.shared.execute(request, expecting: RecentlySongsModel.self)
                .sink { completion in
                    switch completion {
                    case .finished: break
                    case .failure(let error):
                        print("Error: \(error)")
                    }
                } receiveValue: { response in
                    for song in response.items {
                        let songsName = self.truncateSongName(song.track.name)
                        guard let artistName = song.track.artists.first?.name else { return }
                        guard let url = song.track.album.images.first?.url else { return }
                        guard let imageUrl = URL(string: url) else { return }
                        guard let playedAt = self.formatDate(song.playedAt) else { return }
                       
                        let viewModel = RecentlyPlayedSongs(songName: songsName, playedAt: playedAt, artistName: artistName, image: imageUrl)
                        
                        self.firstSectionData.append(viewModel)
                    }
                    self.delegate?.didFetchData()
                }
                .store(in: &self.cancellables)
        }
    }


    
    private func formatDate(_ dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "MMM dd, HH:mm"
            return dateFormatter.string(from: date)
        } else {
            return nil
        }
    }
    
    private func truncateSongName(_ songName: String) -> String {
        let words = songName.components(separatedBy: " ")
        if words.count > 5 {
            return words.prefix(3).joined(separator: " ") + " ..."
        } else {
            return songName
        }
    }

}
