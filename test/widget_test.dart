
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:corrida_territorial/main.dart';

void main() {
  testWidgets('App starts and shows onboarding test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ProviderScope(
      child: CorridaTerritorialApp(),
    ));

    // Wait for the GoRouter to resolve the initial route (delay or settle)
    await tester.pumpAndSettle();

    // Verify that onboarding screen shows up because it starts unauthenticated
    expect(find.text('Corra.\nConquiste.\nDomine.'), findsOneWidget);
  });
}
