import 'dart:ffi';

import 'package:is_tv_ffi/src/is_tv.dart';
import 'package:is_tv_ffi/src/platforms/windows/bindings.dart';

/// Windows-specific implementation of [IsTv].
///
/// Uses FFI to call a native C++ function that checks for a TV-like environment
/// by inspecting environment variables.
class IsTvWindows extends IsTv {
  /// Creates a new instance of [IsTvWindows].
  ///
  /// This constructor loads the `is_tv_ffi_plugin.dll` shared library
  /// and initializes the FFI bindings. It is typically not called directly.
  /// Instead, use [IsTv.instance] which will automatically create the
  /// correct platform implementation.
  IsTvWindows() {
    _dynamicLibrary = DynamicLibrary.open('is_tv_ffi_plugin.dll');

    if (_dynamicLibrary != null) {
      _isTvFfiWindowsPlugin = IsTvFfiWindowsPlugin(_dynamicLibrary!);
    } else {
      throw Exception('Unable to load is_tv_ffi_plugin.dll for $IsTvWindows');
    }
  }

  DynamicLibrary? _dynamicLibrary;
  IsTvFfiWindowsPlugin? _isTvFfiWindowsPlugin;

  @override
  bool get isTv => _isTvFfiWindowsPlugin!.is_tv();
}
