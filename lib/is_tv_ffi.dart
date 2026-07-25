import 'package:is_tv_ffi/src/is_tv.dart';

/// {@template is_tv_ffi}
/// A Flutter plugin to detect if the current device is a TV.
///
/// Example usage:
/// ```dart
/// const isTvFfi = IsTvFfi();
/// if (isTvFfi.isTv) {
///   print('Running on a TV device');
/// } else {
///   print('Not running on a TV device');
/// }
/// ```
/// {@endtemplate}
class IsTvFfi {
  /// {@macro is_tv_ffi}
  const IsTvFfi();

  IsTv get _platform => IsTv.instance;

  /// {@template is_tv_getter}
  /// Returns true if the current device is a TV, false otherwise.
  ///
  /// Platform-specific behavior:
  /// * Android: checks whether `UiModeManager` reports a television UI mode,
  ///   falling back to the leanback system feature.
  /// * iOS/tvOS: checks whether `UIDevice`'s user interface idiom is `.tv`.
  /// * macOS: always false; macOS never reports a TV idiom.
  /// * Linux/Windows: checks the `FLUTTER_IS_TV` environment variable, plus
  ///   the variables set by Steam Big Picture sessions on Linux.
  /// * Web: checks for smart-TV platform globals, then the user agent.
  ///
  /// Example:
  /// ```dart
  /// const isTvFfi = IsTvFfi();
  /// final isTV = isTvFfi.isTv;
  /// ```
  /// {@endtemplate}
  bool get isTv => _platform.isTv;
}
