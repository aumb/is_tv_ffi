// flutter test -r expanded test/entry_points/platforms_tests.dart

import 'package:flutter_test/flutter_test.dart';

import '../is_tv_ffi_test.dart' as is_tv_ffi_test;
import '../src/platforms/android/is_tv_android_test.dart' as is_tv_android_test;
import '../src/platforms/native/is_tv_native_test.dart' as is_tv_native_test;
import '../src/platforms/platforms_test.dart' as platforms_test;
import '../src/platforms/stub_test.dart' as stub_test;

void main() {
  group('Platform Unit Tests', () {
    is_tv_ffi_test.main();
    platforms_test.main();
    stub_test.main();
    is_tv_android_test.main();
    is_tv_native_test.main();
  });
}
