import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:is_tv_ffi/is_tv_ffi.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('IsTvFfi Integration Tests', () {
    testWidgets(
      'isTv returns the expected value for the platform and environment',
      (WidgetTester tester) async {
        const expectedIsTvString = String.fromEnvironment('EXPECTED_IS_TV');

        final bool shouldAssertValue = expectedIsTvString.isNotEmpty;
        final bool expectedValue = expectedIsTvString.toLowerCase() == 'true';

        final isTvFfi = IsTvFfi();
        final bool actualIsTvResult = isTvFfi.isTv;

        expect(actualIsTvResult, isA<bool>());

        if (shouldAssertValue) {
          expect(
            actualIsTvResult,
            expectedValue,
            reason:
                'The actual result did not match the expected value for this test environment.',
          );
        }
      },
    );
  });
}
