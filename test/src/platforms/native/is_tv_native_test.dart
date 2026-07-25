import 'dart:ffi';

import 'package:flutter_test/flutter_test.dart';
import 'package:is_tv_ffi/src/platforms/native/bindings.dart';
import 'package:is_tv_ffi/src/platforms/native/is_tv_native.dart';
import 'package:mocktail/mocktail.dart';

class _MockIsTvFfiNativePlugin extends Mock implements IsTvFfiNativePlugin {}

void main() {
  late _MockIsTvFfiNativePlugin mockPlugin;

  DynamicLibrary neverCalled() =>
      fail('the library must not be resolved before isTv is read');

  setUp(() {
    mockPlugin = _MockIsTvFfiNativePlugin();
  });

  group(IsTvNative, () {
    test('isTv returns true when the native binding returns true', () {
      when(() => mockPlugin.is_tv()).thenReturn(true);
      final isTvNative = IsTvNative(
        resolveLibrary: neverCalled,
        plugin: mockPlugin,
      );

      expect(isTvNative.isTv, isTrue);
      verify(() => mockPlugin.is_tv()).called(1);
    });

    test('isTv returns false when the native binding returns false', () {
      when(() => mockPlugin.is_tv()).thenReturn(false);
      final isTvNative = IsTvNative(
        resolveLibrary: neverCalled,
        plugin: mockPlugin,
      );

      expect(isTvNative.isTv, isFalse);
      verify(() => mockPlugin.is_tv()).called(1);
    });

    test('isTv can be read more than once', () {
      when(() => mockPlugin.is_tv()).thenReturn(true);
      final isTvNative = IsTvNative(
        resolveLibrary: neverCalled,
        plugin: mockPlugin,
      );

      expect(isTvNative.isTv, isTrue);
      expect(isTvNative.isTv, isTrue);
      verify(() => mockPlugin.is_tv()).called(2);
    });

    test('does not resolve the library until isTv is read', () {
      var resolved = 0;

      final isTvNative = IsTvNative(
        resolveLibrary: () {
          resolved++;
          throw ArgumentError('no such library');
        },
      );

      expect(resolved, isZero);
      expect(() => isTvNative.isTv, throwsA(isA<StateError>()));
      expect(resolved, 1);
    });

    test('reports a failed library resolution as a StateError', () {
      final isTvNative = IsTvNative.open('definitely_not_a_real_library');

      expect(
        () => isTvNative.isTv,
        throwsA(
          isA<StateError>().having(
            (error) => error.message,
            'message',
            contains('Unable to resolve the native is_tv symbol'),
          ),
        ),
      );
    });

    test('reports a missing symbol as a StateError', () {
      // The test binary itself is a valid library that does not export
      // `is_tv`, so this exercises the eager symbol lookup rather than the
      // library load.
      final isTvNative = IsTvNative.process();

      expect(
        () => isTvNative.isTv,
        throwsA(
          isA<StateError>().having(
            (error) => error.message,
            'message',
            contains('Unable to resolve the native is_tv symbol'),
          ),
        ),
      );
    });
  });
}
