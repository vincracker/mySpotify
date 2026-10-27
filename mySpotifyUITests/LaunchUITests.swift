import XCTest

final class LaunchUITests: XCTestCase {
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
    }

    @MainActor
    func testLibraryAndPlaylistsTabsExist() {
        let app = XCUIApplication()
        app.launch()

        let library = tab("Library", in: app)
        let playlists = tab("Playlists", in: app)

        XCTAssertTrue(library.exists, "Library tab is missing. \(app.debugDescription)")
        XCTAssertTrue(playlists.exists, "Playlists tab is missing. \(app.debugDescription)")

        playlists.tap()
        XCTAssertTrue(app.staticTexts["No Playlists"].waitForExistence(timeout: 15))

        library.tap()
        XCTAssertTrue(app.staticTexts["No Songs"].waitForExistence(timeout: 15))
    }

    @MainActor
    private func tab(_ name: String, in app: XCUIApplication) -> XCUIElement {
        let inTabBar = app.tabBars.buttons[name]
        if inTabBar.waitForExistence(timeout: 15) {
            return inTabBar
        }
        let button = app.buttons[name]
        _ = button.waitForExistence(timeout: 5)
        return button
    }
}
