import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:is_tv_ffi/src/is_tv.dart';
import 'package:is_tv_ffi/src/platforms/windows/bindings.dart';

/// Windows-specific implementation of [IsTv].
///
/// Uses FFI to call a native C++ function that checks for a TV-like environment
/// by inspecting environment variables.
class IsTvWindows extends IsTv {
  /// Creates a new instance of [IsTvWindows].
  IsTvWindows({@visibleForTesting IsTvFfiWindowsPlugin? plugin})
    : _isTvFfiWindowsPlugin = plugin ?? _loadPlugin();

  final IsTvFfiWindowsPlugin _isTvFfiWindowsPlugin;

  static IsTvFfiWindowsPlugin _loadPlugin() {
    try {
      final dynamicLibrary = DynamicLibrary.open('is_tv_ffi_plugin.dll');
      return IsTvFfiWindowsPlugin(dynamicLibrary);
    } catch (e) {
      throw Exception(
        'Unable to load is_tv_ffi_plugin.dll for $IsTvWindows: $e',
      );
    }
  }

  @override
  bool get isTv => _isTvFfiWindowsPlugin.is_tv();
}
