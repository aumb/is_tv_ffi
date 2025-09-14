import 'package:is_tv_ffi/src/is_tv.dart';

/// {@template is_tv_ffi}
/// A Flutter plugin to detect if the current device is a TV.
///
/// Example usage:
/// ```dart
/// final isTvFfi = IsTvFfi();
/// if (isTvFfi.isTv) {
///   print('Running on a TV device');
/// } else {
///   print('Not running on a TV device');
/// }
/// ```
/// {@endtemplate}
class IsTvFfi {
  IsTv get _platform => IsTv.instance;

  /// {@template is_tv_getter}
  /// Returns true if the current device is a TV, false otherwise.
  ///
  /// Platform-specific behavior:
  /// * Android: Checks if the device is an Android TV
  ///
  /// Example:
  /// ```dart
  /// final isTvFfi = IsTvFfi();
  /// final isTV = isTvFfi.isTv;
  /// ```
  /// {@endtemplate}
  bool get isTv => _platform.isTv;
}
