import 'dart:ui';

class TestMixin {
  String colorToHex(Color color) {
    final a =
        (color.a * 255).toInt().toRadixString(16).padLeft(2, '0').toUpperCase();
    final r =
        (color.r * 255).toInt().toRadixString(16).padLeft(2, '0').toUpperCase();

    final g =
        (color.g * 255).toInt().toRadixString(16).padLeft(2, '0').toUpperCase();

    final b =
        (color.b * 255).toInt().toRadixString(16).padLeft(2, '0').toUpperCase();

    return '#$r$g$b$a';
  }

  String buildIframeUrl({
    required String videoId,
    bool isAutoPlay = false,
    bool isLooping = false,
    bool isMuted = false,
    bool showControls = true,
    bool enableJsApi = true,
    int startAt = 0,
  }) {
    final loopParam = isLooping ? '&playlist=$videoId' : '';
    return 'https://www.youtube.com/embed/$videoId?'
        'autoplay=${isAutoPlay ? 1 : 0}'
        '&loop=${isLooping ? 1 : 0}'
        '$loopParam'
        '&mute=${isMuted ? 1 : 0}'
        '&controls=${showControls ? 1 : 0}'
        '&enablejsapi=${enableJsApi ? 1 : 0}'
        '&start=$startAt';
  }

  String buildHtmlContent({
    required String videoId,
    required Color backgroundColor,
    required double startTime,
  }) {
    return '''
<!DOCTYPE html>
<html>
  <head>
    <style>
      body {
        margin: 0;
        padding: 0;
        background-color: ${colorToHex(backgroundColor)};
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
      <iframe 
        id="player"
        src="${buildIframeUrl(videoId: videoId)}"
        frameborder="0"
        allow="autoplay; fullscreen; picture-in-picture"
        allowfullscreen 
        webkitallowfullscreen 
        mozallowfullscreen>
      </iframe>
    </div>
    <script>
      var player;
      function onYouTubeIframeAPIReady() {
        player = new YT.Player('player', {
          events: {
            'onReady': onPlayerReady
          }
        });
      }
      function onPlayerReady(event) {
        event.target.seekTo($startTime);
      }
    </script>
  </body>
</html>
''';
  }
}
