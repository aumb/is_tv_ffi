import 'package:flutter_test/flutter_test.dart';
import 'package:is_tv_ffi/src/platforms/android/bindings.dart';
import 'package:is_tv_ffi/src/platforms/android/is_tv_android.dart';
import 'package:jni/jni.dart';
import 'package:mocktail/mocktail.dart';

class _MockJObject extends Mock implements JObject {}

void main() {
  late IsTvAndroid isTvAndroid;
  late _MockJObject mockJObject;
  late Context mockContext;

  setUp(() {
    mockJObject = _MockJObject();
    when(() => mockJObject.release()).thenReturn(null);
    mockContext = mockJObject as Context;
  });

  group(IsTvAndroid, () {
    test('isTv returns true when native check is true', () {
      bool mockIsTvCheck(Context _) => true;
      isTvAndroid = IsTvAndroid(context: mockContext, isTvCheck: mockIsTvCheck);

      final result = isTvAndroid.isTv;

      expect(result, isTrue);
      verify(() => mockJObject.release()).called(1);
    });

    test('isTv returns false when native check is false', () {
      bool mockIsTvCheck(Context _) => false;
      isTvAndroid = IsTvAndroid(context: mockContext, isTvCheck: mockIsTvCheck);

      final result = isTvAndroid.isTv;

      expect(result, isFalse);
      verify(() => mockJObject.release()).called(1);
    });
  });
}
