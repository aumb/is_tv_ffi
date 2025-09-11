import 'package:flutter_test/flutter_test.dart';
import 'package:is_tv_ffi/is_tv_ffi.dart';
import 'package:is_tv_ffi/is_tv_ffi_platform_interface.dart';
import 'package:is_tv_ffi/is_tv_ffi_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockIsTvFfiPlatform
    with MockPlatformInterfaceMixin
    implements IsTvFfiPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final IsTvFfiPlatform initialPlatform = IsTvFfiPlatform.instance;

  test('$MethodChannelIsTvFfi is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelIsTvFfi>());
  });

  test('getPlatformVersion', () async {
    IsTvFfi isTvFfiPlugin = IsTvFfi();
    MockIsTvFfiPlatform fakePlatform = MockIsTvFfiPlatform();
    IsTvFfiPlatform.instance = fakePlatform;

    expect(await isTvFfiPlugin.getPlatformVersion(), '42');
  });
}
