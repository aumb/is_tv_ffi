import 'package:flutter_test/flutter_test.dart';
import 'package:is_tv_ffi/src/is_tv.dart';
import 'package:is_tv_ffi_example/main.dart';

class _FakeIsTv extends IsTv {
  _FakeIsTv({required this.isTv});

  @override
  final bool isTv;
}

void main() {
  tearDown(() {
    // ignore: invalid_use_of_internal_member
    IsTv.setInstance(null);
  });

  testWidgets('shows the TV detection result', (WidgetTester tester) async {
    // ignore: invalid_use_of_internal_member
    IsTv.setInstance(_FakeIsTv(isTv: true));

    await tester.pumpWidget(const MyApp());

    expect(find.text('Is device a tv: true'), findsOneWidget);
  });

  testWidgets('shows false when the device is not a TV', (
    WidgetTester tester,
  ) async {
    // ignore: invalid_use_of_internal_member
    IsTv.setInstance(_FakeIsTv(isTv: false));

    await tester.pumpWidget(const MyApp());

    expect(find.text('Is device a tv: false'), findsOneWidget);
  });
}
