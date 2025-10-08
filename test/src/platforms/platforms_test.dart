import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:is_tv_ffi/src/is_tv.dart';
import 'package:is_tv_ffi/src/platforms/platforms.dart' as platforms;
import 'package:mocktail/mocktail.dart';

class _MockIsTv extends Mock implements IsTv {}

void main() {
  final mockIsTvAndroid = _MockIsTv();
  final mockIsTvIos = _MockIsTv();
  final mockIsTvMacos = _MockIsTv();
  final mockIsTvLinux = _MockIsTv();
  final mockIsTvWindows = _MockIsTv();

  final mockFactories = <TargetPlatform, platforms.IsTvFactory>{
    TargetPlatform.android: () => mockIsTvAndroid,
    TargetPlatform.iOS: () => mockIsTvIos,
    TargetPlatform.macOS: () => mockIsTvMacos,
    TargetPlatform.linux: () => mockIsTvLinux,
    TargetPlatform.windows: () => mockIsTvWindows,
  };
  late final Map<TargetPlatform, platforms.IsTvFactory> originalFactories;

  setUpAll(() {
    originalFactories = platforms.platformFactories;
    platforms.platformFactories = mockFactories;
  });

  tearDownAll(() {
    platforms.platformFactories = originalFactories;
  });

  group('getIsTvInstance', () {
    test('returns the correct mock instance for Android', () {
      debugDefaultTargetPlatformOverride = TargetPlatform.android;

      expect(platforms.getIsTvInstance(), same(mockIsTvAndroid));
      debugDefaultTargetPlatformOverride = null;
    });

    test('returns the correct mock instance for iOS', () {
      debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
      expect(platforms.getIsTvInstance(), same(mockIsTvIos));
      debugDefaultTargetPlatformOverride = null;
    });

    test('returns the correct mock instance for macOS', () {
      debugDefaultTargetPlatformOverride = TargetPlatform.macOS;
      expect(platforms.getIsTvInstance(), same(mockIsTvMacos));
      debugDefaultTargetPlatformOverride = null;
    });

    test('returns the correct mock instance for Linux', () {
      debugDefaultTargetPlatformOverride = TargetPlatform.linux;
      expect(platforms.getIsTvInstance(), same(mockIsTvLinux));
      debugDefaultTargetPlatformOverride = null;
    });

    test('returns the correct mock instance for Windows', () {
      debugDefaultTargetPlatformOverride = TargetPlatform.windows;
      expect(platforms.getIsTvInstance(), same(mockIsTvWindows));
      debugDefaultTargetPlatformOverride = null;
    });

    test('throws UnsupportedError for Fuchsia', () {
      debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
      expect(
        () => platforms.getIsTvInstance(),
        throwsA(isA<UnsupportedError>()),
      );
      debugDefaultTargetPlatformOverride = null;
    });
  });
}
