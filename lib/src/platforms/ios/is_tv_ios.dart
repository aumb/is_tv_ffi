import 'dart:ffi';

import 'package:is_tv_ffi/src/is_tv.dart';
import 'package:is_tv_ffi/src/platforms/ios/bindings.dart';

/// IOS-specific implementation of [IsTv].
///
/// Uses IOS's native APIs through FFI to detect if the device is an Apple TV.
/// This implementation checks the device configuration and user interface idiom
/// to determine if it's running on an Apple TV device.
class IsTvIOS extends IsTv {
  /// Creates a new instance of [IsTvIOS].
  ///
  /// This constructor is typically not called directly. Instead, use [IsTv.instance]
  /// which will automatically create the correct platform implementation.
  IsTvIOS() {
    _dynamicLibrary = DynamicLibrary.process();

    if (_dynamicLibrary != null) {
      _isTvFfiIOSPlugin = IsTvFfiIOSPlugin(_dynamicLibrary!);
    } else {
      throw Exception('Unable to initialize $IsTvIOS');
    }
  }

  DynamicLibrary? _dynamicLibrary;
  IsTvFfiIOSPlugin? _isTvFfiIOSPlugin;

  @override
  bool get isTv => _isTvFfiIOSPlugin!.is_tv();
}
