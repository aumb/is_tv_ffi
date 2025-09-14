import 'package:flutter/foundation.dart';
import 'package:is_tv_ffi/src/platforms/android/is_tv_android.dart';

abstract class IsTv {
  bool get isTv;

  static IsTv? _instance;

  static IsTv get instance {
    if (_instance != null) return _instance!;

    _instance = switch (defaultTargetPlatform) {
      TargetPlatform.android => IsTvAndroid(),
      _ => throw UnsupportedError(
        'Unsupported platform: $defaultTargetPlatform',
      ),
    };
    return _instance!;
  }

  @visibleForTesting
  static void setInstance(IsTv? instance) {
    _instance = instance;
  }
}
