import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_mixin.dart'; // Bu dosyada FlutterYoutubePlayerMixin içeren TestMixin olduğunu varsayıyorum.

void main() {
  group('FlutterYoutubePlayerMixin', () {
    test('colorToHex converts Color to hex string correctly', () {
      final mixin = TestMixin();
      final color = Colors.red;
      final hex = mixin.colorToHex(color);
      expect(hex, '#F44336FF');
    });

    test('buildIframeUrl includes all parameters correctly', () {
      final mixin = TestMixin();
      final url = mixin.buildIframeUrl(
        videoId: 'dQw4w9WgXcQ',
        isAutoPlay: true,
        isLooping: true,
        isMuted: true,
        showControls: true,
        enableJsApi: true,
        startAt: 42,
      );
      expect(url, contains('embed/dQw4w9WgXcQ'));
      expect(url, contains('autoplay=1'));
      expect(url, contains('loop=1'));
      expect(url, contains('mute=1'));
      expect(url, contains('controls=1'));
      expect(url, contains('enablejsapi=1'));
      expect(url, contains('start=42'));
    });

    test('buildHtmlContent includes correct HTML structure', () {
      final mixin = TestMixin();
      final html = mixin.buildHtmlContent(
        videoId: 'dQw4w9WgXcQ',
        backgroundColor: Colors.black,
        startTime: 0.0,
      );
      expect(html, contains('<!DOCTYPE html>'));
      expect(html, contains('<html>'));
      expect(html, contains('<head>'));
      expect(html, contains('<body>'));
      expect(html, contains('video-container'));
      expect(html, contains('https://www.youtube.com/iframe_api'));
      expect(html, contains('new YT.Player'));
    });

    test('buildHtmlContent includes correct background color', () {
      final mixin = TestMixin();
      final html = mixin.buildHtmlContent(
        videoId: 'dQw4w9WgXcQ',
        backgroundColor: Colors.black,
        startTime: 0.0,
      );
      expect(html, contains('background-color: #000000'));
    });

    test('buildHtmlContent includes correct iframe URL', () {
      final mixin = TestMixin();
      final html = mixin.buildHtmlContent(
        videoId: 'dQw4w9WgXcQ',
        backgroundColor: Colors.black,
        startTime: 0.0,
      );
      expect(html, contains('src="https://www.youtube.com/embed/dQw4w9WgXcQ'));
    });
  });
}
