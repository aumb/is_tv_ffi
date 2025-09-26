import 'dart:ffi';

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
  ///
  /// This constructor loads the `libis_tv_ffi_plugin.so` shared library
  /// and initializes the FFI bindings. It is typically not called directly.
  /// Instead, use [IsTv.instance] which will automatically create the
  /// correct platform implementation.
  IsTvLinux() {
    _dynamicLibrary = DynamicLibrary.open('libis_tv_ffi_plugin.so');

    if (_dynamicLibrary != null) {
      _isTvFfiLinuxPlugin = IsTvFfiLinuxPlugin(_dynamicLibrary!);
    } else {
      throw Exception('Unable to load libis_tv_ffi_plugin.so for $IsTvLinux');
    }
  }

  DynamicLibrary? _dynamicLibrary;
  IsTvFfiLinuxPlugin? _isTvFfiLinuxPlugin;

  @override
  bool get isTv => _isTvFfiLinuxPlugin!.is_tv();
}
