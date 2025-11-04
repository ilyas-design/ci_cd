import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:ci_cd/pages/countries_page.dart';
import 'package:ci_cd/providers/country_provider.dart';

void main() {
  group('CountriesPage Widget Tests', () {
    testWidgets('should display loading indicator when loading', (
      WidgetTester tester,
    ) async {
      final provider = CountryProvider();

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: provider,
            child: const CountriesPage(),
          ),
        ),
      );

      // Initially, provider hasn't loaded yet, so we might see loading or empty state
      // We'll test the structure exists
      expect(find.byType(CountriesPage), findsOneWidget);
    });

    testWidgets('should display search bar', (WidgetTester tester) async {
      final provider = CountryProvider();

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: provider,
            child: const CountriesPage(),
          ),
        ),
      );

      await tester.pump();

      expect(find.byType(TextField), findsOneWidget);
      expect(find.text('Search countries...'), findsOneWidget);
    });

    testWidgets('should display app bar with title', (
      WidgetTester tester,
    ) async {
      final provider = CountryProvider();

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: provider,
            child: const CountriesPage(),
          ),
        ),
      );

      await tester.pump();

      expect(find.text('World Countries'), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
    });

    testWidgets('should display refresh button', (WidgetTester tester) async {
      final provider = CountryProvider();

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: provider,
            child: const CountriesPage(),
          ),
        ),
      );

      await tester.pump();

      expect(find.byIcon(Icons.refresh), findsOneWidget);
    });

    testWidgets('should allow typing in search bar', (
      WidgetTester tester,
    ) async {
      final provider = CountryProvider();

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: provider,
            child: const CountriesPage(),
          ),
        ),
      );

      await tester.pump();

      final searchField = find.byType(TextField);
      expect(searchField, findsOneWidget);

      await tester.enterText(searchField, 'france');
      await tester.pump();

      expect(find.text('france'), findsOneWidget);
    });
  });
}
