import 'package:flutter_test/flutter_test.dart';

import 'package:example/main.dart';

void main() {
  testWidgets('shows the fetch actions', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Fetch All...'), findsOneWidget);
    expect(find.text('Single Fetch...'), findsOneWidget);
  });
}
