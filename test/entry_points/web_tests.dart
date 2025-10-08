// flutter test -r expanded --platform chrome test/entry_points/web_tests.dart

import 'package:flutter_test/flutter_test.dart';

import '.././src/platforms/stub_test.dart' as stub_test;
import '.././src/platforms/web/bindings_test.dart' as web_bindings_test;
import '.././src/platforms/web/is_tv_web_test.dart' as is_tv_web_test;
import '../is_tv_ffi_test.dart' as is_tv_ffi_test;

void main() {
  group('Web Unit Tests', () {
    is_tv_ffi_test.main();
    stub_test.main();
    is_tv_web_test.main();
    web_bindings_test.main();
  });
}
