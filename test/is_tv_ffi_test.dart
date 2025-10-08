import 'package:flutter_test/flutter_test.dart';
import 'package:is_tv_ffi/is_tv_ffi.dart';
import 'package:is_tv_ffi/src/is_tv.dart';
import 'package:mocktail/mocktail.dart';

class _MockIsTv extends Mock implements IsTv {}

void main() {
  late IsTvFfi isTvFfi;
  late _MockIsTv mockIsTv;

  setUp(() {
    mockIsTv = _MockIsTv();
    isTvFfi = IsTvFfi();
    IsTv.setInstance(mockIsTv);
  });

  tearDown(() {
    IsTv.setInstance(null);
  });

  group(IsTvFfi, () {
    test('isTv should call the platform implementation and return true', () {
      when(() => mockIsTv.isTv).thenReturn(true);

      final result = isTvFfi.isTv;

      expect(result, isTrue);
      verify(() => mockIsTv.isTv).called(1);
    });

    test('isTv should call the platform implementation and return false', () {
      when(() => mockIsTv.isTv).thenReturn(false);

      final result = isTvFfi.isTv;

      expect(result, isFalse);
      verify(() => mockIsTv.isTv).called(1);
    });
  });
}
