import 'package:is_tv_ffi/src/is_tv.dart';
import 'package:is_tv_ffi/src/platforms/web/bindings.dart';

/// Web implementation of [IsTv].
///
/// Uses JS to check on the user agent through FFI to detect if the application
/// is running on a TV.
class IsTvWeb extends IsTv {
  /// Creates a new instance of [IsTvWeb].
  ///
  /// This constructor is typically not called directly. Instead, use [IsTv.instance]
  /// which will automatically create the correct platform implementation.
  IsTvWeb({IsTvFfiWebPlugin? isTvFfiWebPlugin})
    : _isTvFfiWebPlugin = isTvFfiWebPlugin ?? const IsTvFfiWebPlugin();

  final IsTvFfiWebPlugin _isTvFfiWebPlugin;

  @override
  bool get isTv => _isTvFfiWebPlugin.isTv();
}
