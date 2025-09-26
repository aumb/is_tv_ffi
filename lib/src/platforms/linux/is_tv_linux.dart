import 'dart:ffi';

import 'package:is_tv_ffi/src/is_tv.dart';
import 'package:is_tv_ffi/src/platforms/linux/bindings.dart';

/// IOS-specific implementation of [IsTv].
///
/// Uses IOS's native APIs through FFI to detect if the device is an Apple TV.
/// This implementation checks the device configuration and user interface idiom
/// to determine if it's running on an Apple TV device.
class IsTvLinux extends IsTv {
  /// Creates a new instance of [IsTvLinux].
  ///
  /// This constructor is typically not called directly. Instead, use [IsTv.instance]
  /// which will automatically create the correct platform implementation.
  IsTvLinux() {
    _dynamicLibrary = DynamicLibrary.process();

    if (_dynamicLibrary != null) {
      _isTvFfiLinuxPlugin = IsTvFfiLinuxPlugin(_dynamicLibrary!);
    } else {
      throw Exception('Unable to initialize $IsTvLinux');
    }
  }

  DynamicLibrary? _dynamicLibrary;
  IsTvFfiLinuxPlugin? _isTvFfiLinuxPlugin;

  @override
  bool get isTv => _isTvFfiLinuxPlugin!.is_tv();
}
