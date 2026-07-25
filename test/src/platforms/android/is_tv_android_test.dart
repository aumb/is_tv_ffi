import 'package:flutter_test/flutter_test.dart';
import 'package:is_tv_ffi/src/platforms/android/bindings.dart';
import 'package:is_tv_ffi/src/platforms/android/is_tv_android.dart';
import 'package:jni/jni.dart';
import 'package:mocktail/mocktail.dart';

class _MockJObject extends Mock implements JObject {}

void main() {
  late List<_MockJObject> acquired;

  // `Context` is an extension type over `JObject`, so its representation is
  // erased at runtime and a mocked `JObject` stands in for one. This is the
  // only place that relies on that, so it is the only place to fix should
  // jnigen ever change how `Context` is represented.
  Context provideContext() {
    final jObject = _MockJObject();
    when(() => jObject.release()).thenReturn(null);
    acquired.add(jObject);
    return jObject as Context;
  }

  setUp(() {
    acquired = <_MockJObject>[];
  });

  group(IsTvAndroid, () {
    test('isTv returns true when native check is true', () {
      final isTvAndroid = IsTvAndroid(
        contextProvider: provideContext,
        isTvCheck: (_) => true,
      );

      expect(isTvAndroid.isTv, isTrue);
      expect(acquired, hasLength(1));
      verify(() => acquired.single.release()).called(1);
    });

    test('isTv returns false when native check is false', () {
      final isTvAndroid = IsTvAndroid(
        contextProvider: provideContext,
        isTvCheck: (_) => false,
      );

      expect(isTvAndroid.isTv, isFalse);
      expect(acquired, hasLength(1));
      verify(() => acquired.single.release()).called(1);
    });

    test('isTv can be read more than once', () {
      // Regression test: caching a single context and releasing it with `use`
      // made every read after the first throw a UseAfterReleaseError.
      final isTvAndroid = IsTvAndroid(
        contextProvider: provideContext,
        isTvCheck: (_) => true,
      );

      expect(isTvAndroid.isTv, isTrue);
      expect(isTvAndroid.isTv, isTrue);
      expect(isTvAndroid.isTv, isTrue);

      expect(acquired, hasLength(3));
      for (final jObject in acquired) {
        verify(() => jObject.release()).called(1);
      }
    });

    test('releases the context even when the native check throws', () {
      final isTvAndroid = IsTvAndroid(
        contextProvider: provideContext,
        isTvCheck: (_) => throw StateError('boom'),
      );

      expect(() => isTvAndroid.isTv, throwsStateError);
      expect(acquired, hasLength(1));
      verify(() => acquired.single.release()).called(1);
    });

    test('does not touch JNI until isTv is read', () {
      var provided = 0;

      IsTvAndroid(
        contextProvider: () {
          provided++;
          return provideContext();
        },
        isTvCheck: (_) => true,
      );

      expect(provided, isZero);
    });
  });
}
