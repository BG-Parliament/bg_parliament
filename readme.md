# BG_Parliament

A lightweight Flutter client designed to display the live HLS stream from the Bulgarian Parliament. The app maintains an awake screen state and features an NTP synchronized clock.

## Disclaimer

This project does **not** claim any rights to the video stream content. All rights belong to their respective owners. This app simply provides a Flutter-based interface to access the stream.

## License

The source code of this project is licensed under the [GNU General Public License v3.0 (GPL-3.0)](https://www.gnu.org/licenses/gpl-3.0.en.html). By using or modifying this software, you agree to the terms of this license.

## Building and Running

### Prerequisites

- Flutter 3.x or newer installed
- Platform specific toolchains configured for your target (Android, iOS, Web, Desktop)

### Installation steps

1. Clone this repository:
```
git clone <repo>
cd <repo>
```
2. Fetch dependencies:
```
flutter pub get
```
3. Build and run on your target device or emulator:
```
flutter run
```
4. Build releases:
```
flutter build apk --release --split-per-abi --target-platform android-arm,android-arm64,android-x64
```

## Features

- HLS video playback powered by `video_player` and `chewie` packages.
- Displays a user friendly message when the stream is unavailable.
- Clock synchronized with NTP, updating every minute.
- Keeps the device screen awake during playback.
- Exit app via close button.

## Project Structure

- `lib/main.dart` – Core application logic.
- `assets/icon/icon.png` – Application icon source.
- Platform specific folders: `android/`, `ios/`, `web/`, `macos/`, `windows/`, `linux/`.

## Contributing

Contributions are welcome! Please submit small, focused patches with clear descriptions. Ensure your code is clean, readable, and follows K&R best practices.
