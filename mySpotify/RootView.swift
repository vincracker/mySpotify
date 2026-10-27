import SwiftUI

struct RootView: View {
    var body: some View {
        TabView {
            Tab("Library", systemImage: "music.note.list") {
                LibraryView()
            }
            Tab("Playlists", systemImage: "rectangle.stack") {
                PlaylistsView()
            }
        }
    }
}
