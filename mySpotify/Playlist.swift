import Foundation
import SwiftData

@Model
final class Playlist {
    var name: String = ""
    var createdAt: Date = Date.now
    var songFileNames: [String] = []

    @Relationship(deleteRule: .nullify, inverse: \Song.playlists)
    var songs: [Song] = []

    init(name: String, createdAt: Date = .now) {
        self.name = name
        self.createdAt = createdAt
        self.songFileNames = []
        self.songs = []
    }

    var orderedSongs: [Song] {
        songFileNames.compactMap { fileName in
            songs.first { $0.fileName == fileName }
        }
    }

    func replaceSongs(with newSongs: [Song]) {
        songs = newSongs
        songFileNames = newSongs.map(\.fileName)
    }
}
