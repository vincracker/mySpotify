import SwiftUI

struct LibraryView: View {
    var body: some View {
        NavigationStack {
            ContentUnavailableView(
                "No Songs",
                systemImage: "music.note",
                description: Text("Songs you import from Files stay in this app and play offline.")
            )
            .navigationTitle("Library")
        }
    }
}
