import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'is_tv_ffi_platform_interface.dart';

/// An implementation of [IsTvFfiPlatform] that uses method channels.
class MethodChannelIsTvFfi extends IsTvFfiPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('is_tv_ffi');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
