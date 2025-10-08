import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:is_tv_ffi/src/is_tv.dart';
import 'package:is_tv_ffi/src/platforms/ios/bindings.dart';

/// IOS-specific implementation of [IsTv].
///
/// Uses IOS's native APIs through FFI to detect if the device is an Apple TV.
/// This implementation checks the device configuration and user interface idiom
/// to determine if it's running on an Apple TV device.
class IsTvIOS extends IsTv {
  /// Creates a new instance of [IsTvIOS].
  IsTvIOS({@visibleForTesting IsTvFfiIOSPlugin? plugin})
    : _isTvFfiIOSPlugin = plugin ?? _loadPlugin();

  final IsTvFfiIOSPlugin _isTvFfiIOSPlugin;

  static IsTvFfiIOSPlugin _loadPlugin() {
    try {
      final dynamicLibrary = DynamicLibrary.process();
      return IsTvFfiIOSPlugin(dynamicLibrary);
    } catch (e) {
      throw Exception('Unable to initialize $IsTvIOS: $e');
    }
  }

  @override
  bool get isTv => _isTvFfiIOSPlugin.is_tv();
}
