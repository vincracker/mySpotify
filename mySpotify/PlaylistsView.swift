import SwiftUI

struct PlaylistsView: View {
    var body: some View {
        NavigationStack {
            ContentUnavailableView(
                "No Playlists",
                systemImage: "rectangle.stack",
                description: Text("Playlists you create will appear here.")
            )
            .navigationTitle("Playlists")
        }
    }
}
