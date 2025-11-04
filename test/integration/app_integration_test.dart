import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ci_cd/main.dart';
import 'package:ci_cd/pages/countries_page.dart';

void main() {
  group('App Integration Tests', () {
    testWidgets('should navigate from home to countries page', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MyApp());

      // Wait for initial frame
      await tester.pump();

      // Verify home page is displayed
      expect(find.text('World Countries'), findsOneWidget);
      expect(
        find.text('Explore countries from around the world'),
        findsOneWidget,
      );

      // Find and tap the "Explore Countries" button
      final exploreButton = find.text('Explore Countries');
      expect(exploreButton, findsOneWidget);

      await tester.tap(exploreButton);
      await tester.pumpAndSettle();

      // Verify navigation to countries page
      expect(find.byType(CountriesPage), findsOneWidget);
      expect(find.text('World Countries'), findsAtLeastNWidgets(1));
    });

    testWidgets('should display home page correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MyApp());
      await tester.pump();

      // Verify main elements are present
      expect(find.byIcon(Icons.public), findsOneWidget);
      expect(find.text('World Countries'), findsOneWidget);
      expect(find.text('Explore Countries'), findsOneWidget);
      expect(find.text('Get Started'), findsOneWidget);
    });

    testWidgets('should have provider setup', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.pump();

      // Verify that the app has Provider setup
      final app = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(app, isNotNull);
    });
  });
}
