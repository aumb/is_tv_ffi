import 'package:flutter/foundation.dart';
import 'package:is_tv_ffi/src/platforms/paltform_locator.dart';

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
    return _instance ??= platformInstance;
  }

  /// Sets the singleton instance of [IsTv].
  @internal
  static void setInstance(IsTv? instance) {
    _instance = instance;
  }
}
