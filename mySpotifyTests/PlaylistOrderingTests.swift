import SwiftData
import XCTest
@testable import mySpotify

@MainActor
final class PlaylistOrderingTests: XCTestCase {
    private var contexts: [ModelContext] = []

    func testAssignedSongOrderPersists() throws {
        let schema = Schema([Song.self, Playlist.self])
        let configuration = ModelConfiguration(
            "PlaylistOrderingTests",
            schema: schema,
            isStoredInMemoryOnly: true,
            cloudKitDatabase: .none
        )
        let container = try ModelContainer(for: schema, configurations: [configuration])
        let context = ModelContext(container)
        contexts.append(context)

        let alpha = Song(title: "Alpha", artist: "Ava", album: "One", duration: 100, fileName: "alpha.m4a")
        let bravo = Song(title: "Bravo", artist: "Ben", album: "One", duration: 200, fileName: "bravo.m4a")
        let charlie = Song(title: "Charlie", artist: "Cleo", album: "One", duration: 300, fileName: "charlie.m4a")
        let playlist = Playlist(name: "Evening")
        context.insert(alpha)
        context.insert(bravo)
        context.insert(charlie)
        context.insert(playlist)
        playlist.replaceSongs(with: [alpha, bravo, charlie])
        try context.save()

        let saved = try loadPlaylist(from: container)
        XCTAssertEqual(saved.songs.count, 3)
        XCTAssertEqual(saved.songFileNames, ["alpha.m4a", "bravo.m4a", "charlie.m4a"])
        XCTAssertEqual(saved.orderedSongs.map(\.title), ["Alpha", "Bravo", "Charlie"])
        XCTAssertEqual(saved.orderedSongs.map(\.artist), ["Ava", "Ben", "Cleo"])
        XCTAssertEqual(saved.orderedSongs.map(\.duration), [100, 200, 300] as [TimeInterval])

        let byTitle = Dictionary(uniqueKeysWithValues: saved.orderedSongs.map { ($0.title, $0) })
        saved.replaceSongs(with: [
            try XCTUnwrap(byTitle["Charlie"]),
            try XCTUnwrap(byTitle["Alpha"]),
            try XCTUnwrap(byTitle["Bravo"]),
        ])
        try XCTUnwrap(saved.modelContext).save()

        let reordered = try loadPlaylist(from: container)
        XCTAssertEqual(reordered.songs.count, 3)
        XCTAssertEqual(reordered.songFileNames, ["charlie.m4a", "alpha.m4a", "bravo.m4a"])
        XCTAssertEqual(reordered.orderedSongs.map(\.title), ["Charlie", "Alpha", "Bravo"])
        XCTAssertEqual(reordered.orderedSongs.map(\.fileName), ["charlie.m4a", "alpha.m4a", "bravo.m4a"])
    }

    private func loadPlaylist(from container: ModelContainer) throws -> Playlist {
        let context = ModelContext(container)
        contexts.append(context)
        let playlists = try context.fetch(FetchDescriptor<Playlist>())
        return try XCTUnwrap(playlists.first)
    }
}
