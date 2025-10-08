import 'package:flutter/foundation.dart';
import 'package:is_tv_ffi/src/is_tv.dart';
import 'package:is_tv_ffi/src/platforms/android/is_tv_android.dart';
import 'package:is_tv_ffi/src/platforms/ios/is_tv_ios.dart';
import 'package:is_tv_ffi/src/platforms/linux/is_tv_linux.dart';
import 'package:is_tv_ffi/src/platforms/macos/is_tv_macos.dart';
import 'package:is_tv_ffi/src/platforms/windows/is_tv_windows.dart';

@visibleForTesting
/// Function type for creating instances of [IsTv].
typedef IsTvFactory = IsTv Function();

@visibleForTesting
/// Mapping of supported platforms to their corresponding factory functions.
Map<TargetPlatform, IsTvFactory> platformFactories = {
  TargetPlatform.android: () => IsTvAndroid(),
  TargetPlatform.iOS: () => IsTvIOS(),
  TargetPlatform.macOS: () => IsTvMacOS(),
  TargetPlatform.linux: () => IsTvLinux(),
  TargetPlatform.windows: () => IsTvWindows(),
};

/// Returns the instance for mobile and desktop platforms.
IsTv getIsTvInstance() {
  final factory = platformFactories[defaultTargetPlatform];

  if (factory != null) {
    return factory();
  }

  throw UnsupportedError('Unsupported platform: $defaultTargetPlatform');
}
