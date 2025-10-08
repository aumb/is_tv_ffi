import 'package:flutter/foundation.dart';
import 'package:is_tv_ffi/src/is_tv.dart';
import 'package:is_tv_ffi/src/platforms/android/bindings.dart';
import 'package:jni/jni.dart';

@visibleForTesting
/// Function type for checking if the device is a TV given a [Context].
typedef IsTvCheck = bool Function(Context);

/// Android-specific implementation of [IsTv].
///
/// Uses Android's native APIs through JNI to detect if the device is an Android TV.
/// This implementation checks the device configuration and UI mode to determine
/// if it's running on an Android TV device.
class IsTvAndroid extends IsTv {
  /// Creates a new instance of [IsTvAndroid].
  IsTvAndroid({
    @visibleForTesting Context? context,
    @visibleForTesting IsTvCheck? isTvCheck,
  }) : _context =
           context ?? Context.fromReference(Jni.getCachedApplicationContext()),
       _isTvCheck = isTvCheck ?? IsTvFfiPlugin.isTv;

  final Context _context;
  final IsTvCheck _isTvCheck;

  @override
  bool get isTv => _context.use<bool>((context) => _isTvCheck(context));
}
