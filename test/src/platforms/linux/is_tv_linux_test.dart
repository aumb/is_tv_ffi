import 'package:flutter_test/flutter_test.dart';
import 'package:is_tv_ffi/src/platforms/linux/bindings.dart';
import 'package:is_tv_ffi/src/platforms/linux/is_tv_linux.dart';
import 'package:mocktail/mocktail.dart';

class _MockIsTvFfiLinuxPlugin extends Mock implements IsTvFfiLinuxPlugin {}

void main() {
  late IsTvLinux isTvLinux;
  late _MockIsTvFfiLinuxPlugin mockPlugin;

  setUp(() {
    mockPlugin = _MockIsTvFfiLinuxPlugin();
  });

  group(IsTvLinux, () {
    test('isTv returns true when the native binding returns true', () {
      when(() => mockPlugin.is_tv()).thenReturn(true);
      isTvLinux = IsTvLinux(plugin: mockPlugin);

      final result = isTvLinux.isTv;

      expect(result, isTrue);
      verify(() => mockPlugin.is_tv()).called(1);
    });

    test('isTv returns false when the native binding returns false', () {
      when(() => mockPlugin.is_tv()).thenReturn(false);
      isTvLinux = IsTvLinux(plugin: mockPlugin);

      final result = isTvLinux.isTv;

      expect(result, isFalse);
      verify(() => mockPlugin.is_tv()).called(1);
    });
  });
}
