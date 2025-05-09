import 'dart:developer' as dev;
import 'package:flutter/widgets.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'flutter_youtube_player.dart';

/// A mixin that provides common functionality for the FlutterFlutterPlayer widget
/// This mixin can be used to add common functionality
///  to the FlutterFlutterPlayer widget.
/// It is used to manage the state of the player, handle events, and provide
mixin FlutterYoutubePlayerMixin on State<FlutterYoutubePlayer> {
  /// Converts Color to a hexadecimal string
  String colorToHex(Color color) {
    final a = (color.a * 255)
        .toInt()
        .toRadixString(16)
        .padLeft(2, '0'); // Alpha
    final r = (color.r * 255).toInt().toRadixString(16).padLeft(2, '0'); // Red
    final g = (color.g * 255)
        .toInt()
        .toRadixString(16)
        .padLeft(2, '0'); // Green
    final b = (color.b * 255).toInt().toRadixString(16).padLeft(2, '0'); // Blue

    return '#$r$g$b$a'; // Return hex color
  }

  /// Builds the iframe URL
  String buildIframeUrl() {
    final params = {
      'autoplay': widget.isAutoPlay ? '1' : '0',
      'loop': widget.isLooping ? '1' : '0',
      'mute': widget.isMuted ? '1' : '0',
      'controls': widget.showControls ? '1' : '0',
      'modestbranding': '1',
      'rel': '0',
      'enablejsapi': '1',
      'start': widget.startTime.toInt().toString(),
    };

    final query = params.entries.map((e) => '${e.key}=${e.value}').join('&');
    return 'https://www.youtube.com/embed/${widget.videoId}?$query';
  }

  /// Handles the console messages from the WebView
  void onConsoleMessage(
    InAppWebViewController controller,
    ConsoleMessage consoleMessage,
  ) {
    final message = consoleMessage.message;
    if (widget.showLog) {
      dev.log('onConsoleMessage :: $message');
    }

    // Match the format: eventType: (totalDuration, currentDuration) {}
    final regex = RegExp(r'(\w+): \((\d+\.?\d*), (\d+\.?\d*)\) \{\}');
    final match = regex.firstMatch(message);

    if (match != null) {
      final event = match.group(1); // Event type
      final totalDuration = double.tryParse(
        match.group(2) ?? '0',
      ); // Total duration
      final currentDuration = double.tryParse(
        match.group(3) ?? '0',
      ); // Current duration

      switch (event) {
        case 'onReady':
          widget.onReady?.call(totalDuration, currentDuration);

          if (widget.showLog) {
            dev.log('onReady: Total Duration: $totalDuration seconds');
          }
        case 'onPlay':
          widget.onReady?.call(totalDuration, currentDuration);

          if (widget.showLog) {
            dev.log(
              'onPlay: Total Duration: $totalDuration seconds, Current Duration: $currentDuration seconds',
            );
          }
          widget.onPlay?.call(totalDuration, currentDuration);

        case 'onPause':
          widget.onPause?.call(totalDuration, currentDuration);

          if (widget.showLog) {
            dev.log(
              'onPause: Total Duration: $totalDuration seconds, Current Duration: $currentDuration seconds',
            );
          }
        case 'onFinish':
          widget.onFinish?.call(totalDuration, currentDuration);

          if (widget.showLog) {
            dev.log('onFinish: Total Duration: $totalDuration seconds');
          }
        case 'onSeek':
          widget.onSeek?.call(totalDuration, currentDuration);

          if (widget.showLog) {
            dev.log('onSeek: Current Duration: $currentDuration seconds');
          }
        case 'onTimeUpdate':
          widget.onTimeUpdate?.call(totalDuration, currentDuration);

          if (widget.showLog) {
            dev.log('onTimeUpdate: Current Duration: $currentDuration seconds');
          }
        default:
          if (widget.showLog) {
            dev.log('Unknown event type: $event');
          }
      }
    }
  }

  /// Builds the HTML content for the InAppWebView
  String buildHtmlContent() {
    return '''
<!DOCTYPE html>
<html>
  <head>
    <style>
      body {
        margin: 0;
        padding: 0;
        background-color: ${colorToHex(widget.backgroundColor)};
      }
      .video-container {
        position: relative;
        width: 100%;
        height: 100vh;
      }
      iframe {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
      }
    </style>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <script src="https://www.youtube.com/iframe_api"></script>
  </head>
  <body>
    <div class="video-container">
      <div id="player"></div>
    </div>
    <script>
      var player;

      function onYouTubeIframeAPIReady() {
        player = new YT.Player('player', {
          height: '100%',
          width: '100%',
          videoId: '${widget.videoId}',
          playerVars: {
            autoplay: ${widget.isAutoPlay ? 1 : 0},
            loop: ${widget.isLooping ? 1 : 0},
            mute: ${widget.isMuted ? 1 : 0},
            controls: ${widget.showControls ? 1 : 0},
            rel: 0,
            modestbranding: 1,
            start: ${widget.startTime},
            enablejsapi: 1
          },
          events: {
            'onReady': onPlayerReady,
            'onStateChange': onPlayerStateChange
          }
        });
      }

      function onPlayerReady(event) {
        logEventWithDurations('onReady');
      }

      function onPlayerStateChange(event) {
        const state = event.data;
        switch (state) {
          case YT.PlayerState.PLAYING:
            logEventWithDurations('onPlay');
            break;
          case YT.PlayerState.PAUSED:
            logEventWithDurations('onPause');
            break;
          case YT.PlayerState.ENDED:
            logEventWithDurations('onFinish');
            break;
          case YT.PlayerState.BUFFERING:
            break;
        }
      }

      function logEventWithDurations(eventType) {
        Promise.all([
          player.getDuration(),
          player.getCurrentTime()
        ]).then(([totalDuration, currentDuration]) => {
          console.log(`\${eventType}: (\${totalDuration}, \${currentDuration}) {}`);
        });
      }

      setInterval(() => {
        if (player && player.getCurrentTime) {
          logEventWithDurations('onTimeUpdate');
        }
      }, 1000);
    </script>
  </body>
</html>
''';
  }
}
