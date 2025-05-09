# Flutter YouTube

A Flutter package for playing YouTube videos using the `InAppWebView` plugin. This package provides a customizable YouTube player widget with playback controls, fullscreen support, and callback events. It also includes a utility method to extract video IDs from YouTube URLs.

## Features

- Play YouTube videos using `InAppWebView`
- Extract YouTube video ID from full URLs using `extractId`
- Customizable player settings:
  - Auto-play
  - Looping
  - Muted
  - Show/hide controls
  - Start time configuration
- Fullscreen support
- Background color customization
- Callback events for:
  - Player ready
  - Play
  - Pause
  - Finish
  - Seek
  - Time update

## Installation

Add the following to your `pubspec.yaml` file:

```yaml
dependencies:
  flutter_youtube: ^latest-version
```

Then run:

```bash
flutter pub get
```

## Usage

### Basic Usage

```dart
import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';

class MyYouTubePlayer extends StatelessWidget {
  const MyYouTubePlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterYouTubePlayer(
      videoId: '12345678', // Replace with your YouTube video ID
    );
  }
}
```


### Advanced Usage

```dart
FlutterYouTubePlayer(
  videoId: 'dQw4w9WgXcQ',
  isAutoPlay: true,
  isLooping: false,
  isMuted: false,
  showControls: true,
  startTime: 15.0,
  backgroundColor: Colors.black,
  onReady: (totalDuration, currentDuration) {
    debugPrint('Player ready: Total duration: $totalDuration');
  },
  onPlay: (totalDuration, currentDuration) {
    debugPrint('Video playing at $currentDuration');
  },
  onPause: (totalDuration, currentDuration) {
    debugPrint('Video paused at $currentDuration');
  },
  onFinish: (totalDuration, currentDuration) {
    debugPrint('Video finished');
  },
  onSeek: (totalDuration, currentDuration) {
    debugPrint('Seeked to $currentDuration');
  },
  onTimeUpdate: (totalDuration, currentDuration) {
    debugPrint('Time updated: $currentDuration');
  },
);
```

### Extracting Video ID from a YouTube URL

```dart
import 'package:flutter_youtube/flutter_youtube.dart';

void main() {
  final url = 'https://www.youtube.com/watch?v=1234567';
  final id = extractId(url); // returns '1234567'
  print('Video ID: $id');
}
```
Supported formats:
	•	https://www.youtube.com/watch?v=VIDEO_ID
	•	https://youtu.be/VIDEO_ID
	•	https://youtube.com/embed/VIDEO_ID


## Parameters

| Parameter         | Type                | Default        | Description                              |
|------------------|---------------------|----------------|------------------------------------------|
| `videoId`        | String              | required       | The YouTube video ID                     |
| `isAutoPlay`     | bool                | false          | Whether to auto-play the video           |
| `isLooping`      | bool                | false          | Whether to loop the video                |
| `isMuted`        | bool                | false          | Whether to mute the video                |
| `showControls`   | bool                | true           | Whether to show video controls           |
| `startTime`      | double              | 0.0            | Start time in seconds                    |
| `backgroundColor`| Color               | Colors.black   | Background color of the player           |
| `onReady`        | DurationCallback?   | null           | Called when the video is ready           |
| `onPlay`         | DurationCallback?   | null           | Called when the video starts playing     |
| `onPause`        | DurationCallback?   | null           | Called when the video is paused          |
| `onFinish`       | DurationCallback?   | null           | Called when the video finishes           |
| `onSeek`         | DurationCallback?   | null           | Called when seeking in the video         |
| `onTimeUpdate`   | DurationCallback?   | null           | Called when the video time updates       |


## Example

See the [example](example) directory for a complete example application.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.# flutter_youtube
