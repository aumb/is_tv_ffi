import 'package:flutter_test/flutter_test.dart';
import 'package:is_tv_ffi/src/platforms/windows/bindings.dart';
import 'package:is_tv_ffi/src/platforms/windows/is_tv_windows.dart';
import 'package:mocktail/mocktail.dart';

class _MockIsTvFfiWindowsPlugin extends Mock implements IsTvFfiWindowsPlugin {}

void main() {
  late IsTvWindows isTvWindows;
  late _MockIsTvFfiWindowsPlugin mockPlugin;

  setUp(() {
    mockPlugin = _MockIsTvFfiWindowsPlugin();
  });

  group(IsTvWindows, () {
    test('isTv returns true when the native binding returns true', () {
      when(() => mockPlugin.is_tv()).thenReturn(true);
      isTvWindows = IsTvWindows(plugin: mockPlugin);

      final result = isTvWindows.isTv;

      expect(result, isTrue);
      verify(() => mockPlugin.is_tv()).called(1);
    });

    test('isTv returns false when the native binding returns false', () {
      when(() => mockPlugin.is_tv()).thenReturn(false);
      isTvWindows = IsTvWindows(plugin: mockPlugin);

      final result = isTvWindows.isTv;

      expect(result, isFalse);
      verify(() => mockPlugin.is_tv()).called(1);
    });
  });
}
