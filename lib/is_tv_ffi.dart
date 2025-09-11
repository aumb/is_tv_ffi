
import 'is_tv_ffi_platform_interface.dart';

class IsTvFfi {
  Future<String?> getPlatformVersion() {
    return IsTvFfiPlatform.instance.getPlatformVersion();
  }
}
