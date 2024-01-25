//
//  WTFirstSectionViewModel.swift
//  Wetro
//
//  Created by Ислам Пулатов on 1/24/24.
//

import Foundation

final class WTFirstSectionViewModel {
    
    private let songName: String
    
    init(songName: String) {
        self.songName = songName
    }
    
    var getSongName: String {
        return songName
    }
    
}
