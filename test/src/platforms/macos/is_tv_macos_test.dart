import 'package:flutter_test/flutter_test.dart';
import 'package:is_tv_ffi/src/platforms/macos/bindings.dart';
import 'package:is_tv_ffi/src/platforms/macos/is_tv_macos.dart';
import 'package:mocktail/mocktail.dart';

class _MockIsTvFfiMacOSPlugin extends Mock implements IsTvFfiMacOSPlugin {}

void main() {
  late IsTvMacOS isTvMacOS;
  late _MockIsTvFfiMacOSPlugin mockPlugin;

  setUp(() {
    mockPlugin = _MockIsTvFfiMacOSPlugin();
  });

  group(IsTvMacOS, () {
    test('isTv returns true when the native binding returns true', () {
      when(() => mockPlugin.is_tv()).thenReturn(true);
      isTvMacOS = IsTvMacOS(plugin: mockPlugin);

      final result = isTvMacOS.isTv;

      expect(result, isTrue);
      verify(() => mockPlugin.is_tv()).called(1);
    });

    test('isTv returns false when the native binding returns false', () {
      when(() => mockPlugin.is_tv()).thenReturn(false);
      isTvMacOS = IsTvMacOS(plugin: mockPlugin);

      final result = isTvMacOS.isTv;

      expect(result, isFalse);
      verify(() => mockPlugin.is_tv()).called(1);
    });
  });
}
