# mySpotify

mySpotify is an offline music player for songs you already own. You import audio files from the Files app. The app keeps copies in its own sandbox and plays them, including in the background.

This repository currently contains the app shell: a Library tab, a Playlists tab, SwiftData models for songs and ordered playlists, and the audio background mode.

## Requirements

- Xcode 26 or later, with the iOS 26 SDK
- Deployment target: iOS 26 (one major version behind the current iOS release)

## Run

1. Clone this repository.
2. Open `mySpotify.xcodeproj`.
3. Pick an iPhone simulator, or a connected iPhone.
4. Press Run.

To run on your own iPhone with a free Apple ID, connect the phone, select it as the run destination, and choose your Personal Team under Signing & Capabilities. The project does not set a signing team. The bundle identifier is `com.vincracker.myspotify`.
