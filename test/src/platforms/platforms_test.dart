import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:is_tv_ffi/src/platforms/android/is_tv_android.dart';
import 'package:is_tv_ffi/src/platforms/native/is_tv_native.dart';
import 'package:is_tv_ffi/src/platforms/platforms.dart';

void main() {
  tearDown(() {
    debugDefaultTargetPlatformOverride = null;
  });

  group('getIsTvInstance', () {
    test('returns an IsTvAndroid instance for Android', () {
      debugDefaultTargetPlatformOverride = TargetPlatform.android;

      expect(getIsTvInstance(), isA<IsTvAndroid>());
    });

    for (final platform in [
      TargetPlatform.iOS,
      TargetPlatform.macOS,
      TargetPlatform.linux,
      TargetPlatform.windows,
    ]) {
      test('returns an IsTvNative instance for ${platform.name}', () {
        debugDefaultTargetPlatformOverride = platform;

        expect(getIsTvInstance(), isA<IsTvNative>());
      });
    }

    test('throws UnsupportedError for Fuchsia', () {
      debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;

      expect(getIsTvInstance, throwsA(isA<UnsupportedError>()));
    });
  });
}
