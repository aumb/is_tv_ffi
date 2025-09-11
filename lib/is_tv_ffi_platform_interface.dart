import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'is_tv_ffi_method_channel.dart';

abstract class IsTvFfiPlatform extends PlatformInterface {
  /// Constructs a IsTvFfiPlatform.
  IsTvFfiPlatform() : super(token: _token);

  static final Object _token = Object();

  static IsTvFfiPlatform _instance = MethodChannelIsTvFfi();

  /// The default instance of [IsTvFfiPlatform] to use.
  ///
  /// Defaults to [MethodChannelIsTvFfi].
  static IsTvFfiPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [IsTvFfiPlatform] when
  /// they register themselves.
  static set instance(IsTvFfiPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
