# Bulgarian Parliament Stream Viewer

A lightweight Flutter client designed to display the live HLS stream from the Bulgarian Parliament. The app maintains an awake screen state and features an NTP synchronized clock.

# Disclaimer

This project is not affiliated with, endorsed by, or associated with the Bulgarian National Assembly or any government institution. This project does **not** claim any rights to the video stream content. All rights to the video stream and official symbols belong to their respective owners. This app simply provides a Flutter based interface to access the stream.


## License

The source code of this project is licensed under the [GNU General Public License v3.0 (GPL-3.0)](https://www.gnu.org/licenses/gpl-3.0.en.html). By using or modifying this software, you agree to the terms of this license.

## Building and Running

### Prerequisites

- Flutter 3.x or newer installed
- Platform specific toolchains configured for your target (Android, iOS, Web, Desktop)

### Installation steps

1. Clone this repository:
```
git clone https://github.com/BG-Parliament/bg_parliament
cd bg_parliament
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

## Further Improvements

**Error Messages:**
- **DNS_FAIL**: "DNS lookup failed."
- **HLS_404**: "Stream 404'd. Source is gone or your CDN crapped out. Deal with it."
- **TIMEOUT**: "Connection timed out. Your network is slow. Upgrade or stop whining."
- **CODEC_FAIL**: "Codec failed. Your crappy device can't handle H.264. Buy better hardware."

**Features:**
- **Real stream health checks**: Ping the stream endpoint before initializing to avoid failures.
- **Retry logic**: Uses exponential backoff for reliable recovery.
- **Buffering indicators**: Displays "Buffering..." to keep users informed.
- **NTP fallback chain**: Tries local clock, mobile NTP, then system time for sync.
- **Log levels**: Supports DEBUG, INFO, and ERROR; logs to file for analysis.
- **Kill wakelock on pause**: Releases wakelock to save battery.

## Contributing

Contributions are welcome! Please submit small, focused patches with clear descriptions. Ensure your code is readable, and follows K&R best practices.
