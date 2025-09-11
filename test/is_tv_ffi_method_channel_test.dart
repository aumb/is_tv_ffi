import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:is_tv_ffi/is_tv_ffi_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelIsTvFfi platform = MethodChannelIsTvFfi();
  const MethodChannel channel = MethodChannel('is_tv_ffi');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
