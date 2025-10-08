import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:is_tv_ffi/src/is_tv.dart';
import 'package:is_tv_ffi/src/platforms/macos/bindings.dart';

/// macOS implementation of [IsTv].
///
/// Uses macOS's native APIs through FFI to detect if the application
/// is running on an Apple TV.
class IsTvMacOS extends IsTv {
  /// Creates a new instance of [IsTvMacOS].
  IsTvMacOS({@visibleForTesting IsTvFfiMacOSPlugin? plugin})
    : _isTvFfiMacOSPlugin = plugin ?? _loadPlugin();

  final IsTvFfiMacOSPlugin _isTvFfiMacOSPlugin;

  static IsTvFfiMacOSPlugin _loadPlugin() {
    try {
      final dynamicLibrary = DynamicLibrary.process();
      return IsTvFfiMacOSPlugin(dynamicLibrary);
    } catch (e) {
      throw Exception('Unable to initialize $IsTvMacOS: $e');
    }
  }

  @override
  bool get isTv => _isTvFfiMacOSPlugin.is_tv();
}
