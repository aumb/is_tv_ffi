import 'package:flutter/foundation.dart';
import 'package:is_tv_ffi/src/is_tv.dart';
import 'package:is_tv_ffi/src/platforms/android/bindings.dart';
import 'package:jni/jni.dart';
import 'package:jni_flutter/jni_flutter.dart';

/// Function type for checking if the device is a TV given a [Context].
@visibleForTesting
typedef IsTvCheck = bool Function(Context);

/// Function type for acquiring a JNI reference to the application [Context].
@visibleForTesting
typedef ContextProvider = Context Function();

/// Android-specific implementation of [IsTv].
///
/// Uses Android's native APIs through JNI to detect if the device is an Android
/// TV. This implementation checks the device configuration and UI mode to
/// determine if it's running on an Android TV device.
class IsTvAndroid extends IsTv {
  /// Creates a new instance of [IsTvAndroid].
  IsTvAndroid({
    @visibleForTesting ContextProvider? contextProvider,
    @visibleForTesting IsTvCheck? isTvCheck,
  }) : _contextProvider = contextProvider ?? _applicationContext,
       _isTvCheck = isTvCheck ?? IsTvFfiPlugin.isTv;

  static Context _applicationContext() =>
      androidApplicationContext.as(Context.type, releaseOriginal: true);

  final ContextProvider _contextProvider;
  final IsTvCheck _isTvCheck;

  /// {@macro is_tv_getter}
  ///
  /// Each read acquires a fresh JNI reference to the application context and
  /// releases it again. The reference must not be cached across reads: `use`
  /// deletes it, and any later use of a deleted reference throws a
  /// `UseAfterReleaseError`.
  @override
  bool get isTv => _contextProvider().use(_isTvCheck);
}
