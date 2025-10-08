import 'package:flutter_test/flutter_test.dart';
import 'package:is_tv_ffi/src/platforms/ios/bindings.dart';
import 'package:is_tv_ffi/src/platforms/ios/is_tv_ios.dart';
import 'package:mocktail/mocktail.dart';

class _MockIsTvFfiIOSPlugin extends Mock implements IsTvFfiIOSPlugin {}

void main() {
  late IsTvIOS isTvIOS;
  late _MockIsTvFfiIOSPlugin mockPlugin;

  setUp(() {
    mockPlugin = _MockIsTvFfiIOSPlugin();
  });

  group(IsTvIOS, () {
    test('isTv returns true when the native binding returns true', () {
      when(() => mockPlugin.is_tv()).thenReturn(true);
      isTvIOS = IsTvIOS(plugin: mockPlugin);

      final result = isTvIOS.isTv;

      expect(result, isTrue);
      verify(() => mockPlugin.is_tv()).called(1);
    });

    test('isTv returns false when the native binding returns false', () {
      when(() => mockPlugin.is_tv()).thenReturn(false);
      isTvIOS = IsTvIOS(plugin: mockPlugin);

      final result = isTvIOS.isTv;

      expect(result, isFalse);
      verify(() => mockPlugin.is_tv()).called(1);
    });
  });
}
