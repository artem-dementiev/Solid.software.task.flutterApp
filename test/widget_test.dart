import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:solid_software_app/main.dart';

void main() {
  testWidgets('background change smoke test', (WidgetTester tester) async {

    await tester.pumpWidget(App());

    // Verify that our step starts at 1000.
    expect(find.text('Index change step: 1000'), findsOneWidget);

    // Tap the '+' icon and trigger a frame.
    expect(find.text('16777215'), findsOneWidget);
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    // Verify that our counter has incremented.
    expect(find.text('16778215'), findsOneWidget);

    // Tap the '-' icon and trigger a frame.
    expect(find.text('16778215'), findsOneWidget);
    await tester.tap(find.byIcon(Icons.remove));
    await tester.pump();
    // Verify that our counter has decremented.
    expect(find.text('16777215'), findsOneWidget);

    // Find input and enter the number
    var inputStepField = find.byType(TextFormField);
    await tester.enterText(inputStepField, "500");
    expect(find.text('500'), findsOneWidget);
    // Set step value
    await tester.tap(find.byType(RaisedButton));
    await tester.pump();
    expect(find.text('Index change step: 500'), findsOneWidget);

    // Tap anywhere and get another index
    await tester.tap(find.byType(Scaffold));
    await tester.pump();
    expect(find.text('16777215'), findsNothing);


  });
}
