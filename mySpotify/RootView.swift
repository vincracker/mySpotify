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
        .preferredColorScheme(uiTestColorScheme)
    }

    private var uiTestColorScheme: ColorScheme? {
        let arguments = ProcessInfo.processInfo.arguments
        if arguments.contains("-UITestDarkMode") {
            return .dark
        }
        if arguments.contains("-UITestLightMode") {
            return .light
        }
        return nil
    }
}
