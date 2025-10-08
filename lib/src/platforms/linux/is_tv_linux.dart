import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:is_tv_ffi/src/is_tv.dart';
import 'package:is_tv_ffi/src/platforms/linux/bindings.dart';

/// Linux-specific implementation of [IsTv].
///
/// Uses FFI to call a native C++ function that checks for a TV-like environment.
/// This implementation determines if the device is a TV by checking for specific
/// environment variables, such as `FLUTTER_IS_TV` or those indicating a
/// Steam Big Picture Mode session.
class IsTvLinux extends IsTv {
  /// Creates a new instance of [IsTvLinux].
  IsTvLinux({@visibleForTesting IsTvFfiLinuxPlugin? plugin})
    : _isTvFfiLinuxPlugin = plugin ?? _loadPlugin();

  final IsTvFfiLinuxPlugin _isTvFfiLinuxPlugin;

  static IsTvFfiLinuxPlugin _loadPlugin() {
    try {
      final dynamicLibrary = DynamicLibrary.open('libis_tv_ffi_plugin.so');
      return IsTvFfiLinuxPlugin(dynamicLibrary);
    } catch (e) {
      throw Exception(
        'Unable to load libis_tv_ffi_plugin.so for $IsTvLinux: $e',
      );
    }
  }

  @override
  bool get isTv => _isTvFfiLinuxPlugin.is_tv();
}
