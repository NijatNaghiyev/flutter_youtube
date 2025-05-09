import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_youtube_video/flutter_youtube.dart';

void main() {
  group('FlutterYoutubePlayer', () {
    testWidgets('should throw assertion error when videoId is empty', (
      WidgetTester tester,
    ) async {
      expect(
        () => tester.pumpWidget(
          MaterialApp(home: FlutterYoutubePlayer(videoId: '')),
        ),
        throwsAssertionError,
      );
    });

    test('should create widget with valid videoId', () {
      final widget = FlutterYoutubePlayer(videoId: 'dQw4w9WgXcQ');
      expect(widget.videoId, 'dQw4w9WgXcQ');
    });

    test('should create widget with default values', () {
      final widget = FlutterYoutubePlayer(videoId: 'dQw4w9WgXcQ');
      expect(widget.isAutoPlay, false);
      expect(widget.isLooping, false);
      expect(widget.isMuted, false);
      expect(widget.showControls, true);
      expect(widget.startTime, 0.0);
      expect(widget.backgroundColor, Colors.black);
      expect(widget.showLog, false);
    });

    test('should create widget with custom values', () {
      final widget = FlutterYoutubePlayer(
        videoId: 'dQw4w9WgXcQ',
        isAutoPlay: true,
        isLooping: true,
        isMuted: true,
        showControls: false,
        startTime: 15.0,
        backgroundColor: Colors.red,
        showLog: true,
      );

      expect(widget.isAutoPlay, true);
      expect(widget.isLooping, true);
      expect(widget.isMuted, true);
      expect(widget.showControls, false);
      expect(widget.startTime, 15.0);
      expect(widget.backgroundColor, Colors.red);
      expect(widget.showLog, true);
    });
  });
}
