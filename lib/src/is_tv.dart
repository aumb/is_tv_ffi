import 'package:flutter/foundation.dart';
import 'package:is_tv_ffi/src/platforms/android/is_tv_android.dart';

/// Base class for platform-specific TV detection implementations.
///
/// This abstract class defines the interface for TV detection across different
/// platforms. Platform-specific implementations should extend this class
/// and implement the [isTv] getter.
///
/// Platform implementations are created automatically through [instance]
/// based on the current platform.
abstract class IsTv {
  /// {@macro is_tv_getter}
  bool get isTv;

  static IsTv? _instance;

  /// Returns the platform-specific singleton instance of [IsTv].
  ///
  /// The instance is created lazily on first access and cached for subsequent calls.
  /// Throws [UnsupportedError] if the current platform is not supported.
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

  /// Sets the singleton instance of [IsTv].
  @visibleForTesting
  static void setInstance(IsTv? instance) {
    _instance = instance;
  }
}
