import XCTest

final class LaunchUITests: XCTestCase {
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
    }

    @MainActor
    func testLibraryAndPlaylistsTabsExist() {
        let app = XCUIApplication()

        showLibrary(in: app, appearance: .light)
        attachScreenshot(named: "library-light")
        showPlaylists(in: app)
        attachScreenshot(named: "playlists-light")

        app.terminate()

        showLibrary(in: app, appearance: .dark)
        attachScreenshot(named: "library-dark")
        showPlaylists(in: app)
        attachScreenshot(named: "playlists-dark")
    }

    @MainActor
    private func showLibrary(in app: XCUIApplication, appearance: XCUIDevice.Appearance) {
        XCUIDevice.shared.appearance = appearance
        app.launchArguments = [appearance == .dark ? "-UITestDarkMode" : "-UITestLightMode"]
        app.launch()

        let library = tab("Library", in: app)
        let playlists = tab("Playlists", in: app)
        XCTAssertTrue(library.exists, "Library tab is missing. \(app.debugDescription)")
        XCTAssertTrue(playlists.exists, "Playlists tab is missing. \(app.debugDescription)")

        library.tap()
        XCTAssertTrue(app.staticTexts["No Songs"].waitForExistence(timeout: 15))
    }

    @MainActor
    private func showPlaylists(in app: XCUIApplication) {
        tab("Playlists", in: app).tap()
        XCTAssertTrue(app.staticTexts["No Playlists"].waitForExistence(timeout: 15))
    }

    @MainActor
    private func attachScreenshot(named name: String) {
        let attachment = XCTAttachment(screenshot: XCUIScreen.main.screenshot())
        attachment.name = name
        attachment.lifetime = .keepAlways
        add(attachment)
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
