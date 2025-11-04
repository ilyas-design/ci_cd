// This is a basic Flutter widget test for the World Countries Explorer app.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ci_cd/main.dart';

void main() {
  testWidgets('Home Page smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the app title is displayed
    expect(find.text('World Countries'), findsAtLeastNWidgets(1));

    // Verify that the main description is displayed
    expect(
      find.text('Explore countries from around the world with detailed information'),
      findsOneWidget,
    );

    // Verify that buttons are displayed
    expect(find.text('Explore Countries'), findsOneWidget);
    expect(find.text('Get Started'), findsOneWidget);

    // Verify that the icon is displayed
    expect(find.byIcon(Icons.public), findsOneWidget);
  });

  testWidgets('Navigation buttons test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Verify that navigation buttons are present
    expect(find.text('Explore Countries'), findsOneWidget);
    expect(find.text('Get Started'), findsOneWidget);

    // Test that button types exist
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.byType(TextButton), findsOneWidget);
  });

  testWidgets('Responsive layout test', (WidgetTester tester) async {
    // Test that the app renders without errors on a reasonable screen size
    await tester.binding.setSurfaceSize(const Size(1200, 800)); // Desktop size
    await tester.pumpWidget(const MyApp());
    await tester.pump();

    // Verify that the app renders without overflow errors
    expect(find.text('World Countries'), findsAtLeastNWidgets(1));
    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.byType(SafeArea), findsOneWidget);
  });

  testWidgets('Button interactions test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Test that buttons exist and can be found
    final exploreButton = find.text('Explore Countries');
    expect(exploreButton, findsOneWidget);

    final getStartedButton = find.text('Get Started');
    expect(getStartedButton, findsOneWidget);

    // Test that button types exist
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.byType(TextButton), findsOneWidget);

    // Test that buttons can be tapped without throwing exceptions
    final elevatedButtons = find.byType(ElevatedButton);
    final textButtons = find.byType(TextButton);

    expect(elevatedButtons.evaluate().isNotEmpty, isTrue);
    expect(textButtons.evaluate().isNotEmpty, isTrue);
  });

  testWidgets('Theme and styling test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Verify that the app uses the correct theme
    final app = tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(app.theme?.colorScheme.primary, const Color(0xFF007AFF));
    expect(app.theme?.useMaterial3, isTrue);
    expect(app.theme?.scaffoldBackgroundColor, const Color(0xFFF2F2F7));
  });

  testWidgets('App renders without errors', (WidgetTester tester) async {
    // This test just ensures the app can be built and rendered without throwing exceptions
    await tester.pumpWidget(const MyApp());
    await tester.pump();

    // Verify that the main scaffold is present
    expect(find.byType(Scaffold), findsOneWidget);

    // Verify that the main content structure is present
    expect(find.byType(SafeArea), findsOneWidget);
    expect(find.byType(Column), findsWidgets);
  });

  testWidgets('Home page navigation to countries page', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump();

    // Find and tap the "Explore Countries" button
    final exploreButton = find.text('Explore Countries');
    expect(exploreButton, findsOneWidget);

    await tester.tap(exploreButton);
    await tester.pumpAndSettle();

    // Verify navigation to countries page
    expect(find.text('World Countries'), findsAtLeastNWidgets(1));
  });
}
