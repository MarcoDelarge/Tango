//
//  Album.swift
//  Tango
//
//  Created by sparecdmx on 10/10/22.
//

import Foundation

struct Album: Decodable {
    var artist: String?
    var album: String?
    var cover: String?
    var numberOfSongs: Int?

    private enum CodingKeys: String, CodingKey {
        case artist = "artistName"
        case album = "collectionName"
        case cover = "artworkUrl10"
        case numberOfSongs = "trackCount"
    }
}
