import 'package:flutter_test/flutter_test.dart';
import 'package:is_tv_ffi/src/platforms/android/bindings.dart';
import 'package:is_tv_ffi/src/platforms/android/is_tv_android.dart';
import 'package:mocktail/mocktail.dart';

class _MockContext extends Mock implements Context {}

void main() {
  late IsTvAndroid isTvAndroid;
  late _MockContext mockContext;

  setUp(() {
    mockContext = _MockContext();

    when(() => mockContext.release()).thenReturn(null);
  });

  group(IsTvAndroid, () {
    test('isTv returns true when native check is true', () {
      bool mockIsTvCheck(Context _) => true;
      isTvAndroid = IsTvAndroid(context: mockContext, isTvCheck: mockIsTvCheck);

      final result = isTvAndroid.isTv;

      expect(result, isTrue);
      verify(() => mockContext.release()).called(1);
    });

    test('isTv returns false when native check is false', () {
      bool mockIsTvCheck(Context _) => false;
      isTvAndroid = IsTvAndroid(context: mockContext, isTvCheck: mockIsTvCheck);

      final result = isTvAndroid.isTv;

      expect(result, isFalse);
      verify(() => mockContext.release()).called(1);
    });
  });
}
