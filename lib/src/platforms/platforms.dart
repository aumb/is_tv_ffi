import 'package:flutter/foundation.dart';
import 'package:is_tv_ffi/src/is_tv.dart';
import 'package:is_tv_ffi/src/platforms/android/is_tv_android.dart';
import 'package:is_tv_ffi/src/platforms/ios/is_tv_ios.dart';
import 'package:is_tv_ffi/src/platforms/linux/is_tv_linux.dart';
import 'package:is_tv_ffi/src/platforms/macos/is_tv_macos.dart';
import 'package:is_tv_ffi/src/platforms/windows/is_tv_windows.dart';

/// Returns the instance for mobile and desktop platforms.
IsTv getIsTvInstance() {
  return switch (defaultTargetPlatform) {
    TargetPlatform.android => IsTvAndroid(),
    TargetPlatform.iOS => IsTvIOS(),
    TargetPlatform.macOS => IsTvMacOS(),
    TargetPlatform.linux => IsTvLinux(),
    TargetPlatform.windows => IsTvWindows(),
    _ => throw UnsupportedError('Unsupported platform: $defaultTargetPlatform'),
  };
}
