import SwiftData
import SwiftUI

@main
struct mySpotifyApp: App {
    private let container: ModelContainer

    init() {
        do {
            let schema = Schema([Song.self, Playlist.self])
            let configuration = ModelConfiguration(
                "Library",
                schema: schema,
                cloudKitDatabase: .none
            )
            container = try ModelContainer(for: schema, configurations: [configuration])
        } catch {
            fatalError("Could not open the music library: \(error)")
        }
    }

    var body: some Scene {
        WindowGroup {
            RootView()
        }
        .modelContainer(container)
    }
}
