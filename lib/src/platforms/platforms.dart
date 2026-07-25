import 'package:flutter/foundation.dart';
import 'package:is_tv_ffi/src/is_tv.dart';
import 'package:is_tv_ffi/src/platforms/android/is_tv_android.dart';
import 'package:is_tv_ffi/src/platforms/native/is_tv_native.dart';

/// Returns the instance for mobile and desktop platforms.
///
/// Every implementation resolves its native dependencies lazily, so this only
/// picks a class and never touches JNI or FFI itself.
///
/// Throws [UnsupportedError] if the current platform is not supported.
IsTv getIsTvInstance() => switch (defaultTargetPlatform) {
  TargetPlatform.android => IsTvAndroid(),
  // iOS and macOS link the plugin into the application binary.
  TargetPlatform.iOS || TargetPlatform.macOS => IsTvNative.process(),
  TargetPlatform.linux => IsTvNative.open('libis_tv_ffi_plugin.so'),
  TargetPlatform.windows => IsTvNative.open('is_tv_ffi_plugin.dll'),
  _ => throw UnsupportedError('Unsupported platform: $defaultTargetPlatform'),
};
