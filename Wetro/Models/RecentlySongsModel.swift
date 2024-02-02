//
//  RecentlySongsModel.swift
//  Wetro
//
//  Created by Ислам Пулатов on 1/25/24.
//

import Foundation

// MARK: - RecentlySongsModel
struct RecentlySongsModel: Codable {
    let items: [Item]
    let next: String
    let cursors: Cursors
    let limit: Int
    let href: String
}

// MARK: - Cursors
struct Cursors: Codable {
    let after, before: String
}

// MARK: - Item
struct Item: Codable {
    let track: Track
    let playedAt: String
    let context: Context?

    enum CodingKeys: String, CodingKey {
        case track
        case playedAt = "played_at"
        case context
    }
}

// MARK: - Context
struct Context: Codable {
    let type: String
    let href: String
    let externalUrls: ExternalUrls
    let uri: String

    enum CodingKeys: String, CodingKey {
        case type, href
        case externalUrls = "external_urls"
        case uri
    }
}

// MARK: - ExternalUrls
struct ExternalUrls: Codable {
    let spotify: String
}

// MARK: - Track
struct Track: Codable {
    let album: Album
    let artists: [Artist]
    let availableMarkets: [String]
    let discNumber, durationMS: Int
    let explicit: Bool
    let externalIDS: ExternalIDS
    let externalUrls: ExternalUrls
    let href: String
    let id: String
    let isLocal: Bool
    let name: String
    let popularity: Int
    let previewURL: String?
    let trackNumber: Int
    let type, uri: String

    enum CodingKeys: String, CodingKey {
        case album, artists
        case availableMarkets = "available_markets"
        case discNumber = "disc_number"
        case durationMS = "duration_ms"
        case explicit
        case externalIDS = "external_ids"
        case externalUrls = "external_urls"
        case href, id
        case isLocal = "is_local"
        case name, popularity
        case previewURL = "preview_url"
        case trackNumber = "track_number"
        case type, uri
    }
}

// MARK: - Artist
struct Artist: Codable {
    let externalUrls: ExternalUrls
    let href: String
    let id, name, type, uri: String

    enum CodingKeys: String, CodingKey {
        case externalUrls = "external_urls"
        case href, id, name, type, uri
    }
}

// MARK: - Image
struct Image: Codable {
    let height: Int
    let url: String
    let width: Int
}

// MARK: - ExternalIDS
struct ExternalIDS: Codable {
    let isrc: String
}
