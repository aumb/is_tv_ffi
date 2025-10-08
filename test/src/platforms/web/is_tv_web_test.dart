import 'package:flutter_test/flutter_test.dart';
import 'package:is_tv_ffi/src/platforms/web/bindings.dart';
import 'package:is_tv_ffi/src/platforms/web/is_tv_web.dart';
import 'package:mocktail/mocktail.dart';

class _MockIsTvFfiWebPlugin extends Mock implements IsTvFfiWebPlugin {}

void main() {
  late IsTvWeb isTvWeb;
  late _MockIsTvFfiWebPlugin mockPlugin;

  setUp(() {
    mockPlugin = _MockIsTvFfiWebPlugin();
  });

  group(IsTvWeb, () {
    test('isTv getter delegates to and returns true from the plugin', () {
      when(() => mockPlugin.isTv()).thenReturn(true);
      isTvWeb = IsTvWeb(isTvFfiWebPlugin: mockPlugin);

      final result = isTvWeb.isTv;

      expect(result, isTrue);
      verify(() => mockPlugin.isTv()).called(1);
    });

    test('isTv getter delegates to and returns false from the plugin', () {
      when(() => mockPlugin.isTv()).thenReturn(false);
      isTvWeb = IsTvWeb(isTvFfiWebPlugin: mockPlugin);

      final result = isTvWeb.isTv;

      expect(result, isFalse);
      verify(() => mockPlugin.isTv()).called(1);
    });
  });
}
