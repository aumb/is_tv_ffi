import 'package:is_tv_ffi/src/is_tv.dart';
import 'package:is_tv_ffi/src/platforms/android/bindings.dart';
import 'package:jni/jni.dart';

/// Android-specific implementation of [IsTv].
///
/// Uses Android's native APIs through JNI to detect if the device is an Android TV.
/// This implementation checks the device configuration and UI mode to determine
/// if it's running on an Android TV device.
class IsTvAndroid extends IsTv {
  /// Gets the Android application context.
  ///
  /// Used internally to access Android system services for TV detection.
  Context get _context =>
      Context.fromReference(Jni.getCachedApplicationContext());

  @override
  bool get isTv => _context.use((context) => IsTvFfiPlugin.isTv(context));
}
