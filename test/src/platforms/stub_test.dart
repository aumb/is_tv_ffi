import 'package:flutter_test/flutter_test.dart';
import 'package:is_tv_ffi/src/platforms/stub.dart';

void main() {
  group('Stub', () {
    test('getIsTvInstance throws UnsupportedError', () {
      expect(() => getIsTvInstance(), throwsA(isA<UnsupportedError>()));
    });
  });
}
