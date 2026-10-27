import Foundation
import SwiftData

@Model
final class Song {
    var title: String = ""
    var artist: String = ""
    var album: String = ""
    var duration: TimeInterval = 0
    var fileName: String = ""
    var dateAdded: Date = Date.now
    var playlists: [Playlist] = []

    init(
        title: String,
        artist: String,
        album: String,
        duration: TimeInterval,
        fileName: String,
        dateAdded: Date = .now
    ) {
        self.title = title
        self.artist = artist
        self.album = album
        self.duration = duration
        self.fileName = fileName
        self.dateAdded = dateAdded
        self.playlists = []
    }
}
