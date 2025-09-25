import 'dart:ffi';

import 'package:is_tv_ffi/src/is_tv.dart';
import 'package:is_tv_ffi/src/platforms/macos/bindings.dart';

/// macOS implementation of [IsTv].
///
/// Uses macOS's native APIs through FFI to detect if the application
/// is running on an Apple TV.
class IsTvMacOS extends IsTv {
  /// Creates a new instance of [IsTvMacOS].
  ///
  /// This constructor is typically not called directly. Instead, use [IsTv.instance]
  /// which will automatically create the correct platform implementation.
  IsTvMacOS() {
    _dynamicLibrary = DynamicLibrary.process();

    if (_dynamicLibrary != null) {
      _isTvFfiIOSPlugin = IsTvFfiMacOSPlugin(_dynamicLibrary!);
    } else {
      throw Exception('Unable to initialize $IsTvMacOS');
    }
  }

  DynamicLibrary? _dynamicLibrary;
  IsTvFfiMacOSPlugin? _isTvFfiIOSPlugin;

  @override
  bool get isTv => _isTvFfiIOSPlugin!.is_tv();
}
