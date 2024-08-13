import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project2/Bloc/notification_cubit.dart';
import 'package:project2/app.dart';
import 'package:project2/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
    final navigatorKey =GlobalKey<NavigatorState>();


    await tester.pumpWidget(MyApp(
      scaffoldMessengerKey: scaffoldMessengerKey,
      navigatorKey: navigatorKey,
    ));

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
