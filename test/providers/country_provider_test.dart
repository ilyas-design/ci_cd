import 'package:flutter_test/flutter_test.dart';
import 'package:ci_cd/providers/country_provider.dart';

void main() {
  late CountryProvider provider;

  setUp(() {
    provider = CountryProvider();
  });

  group('CountryProvider Tests', () {
    test('initial state should be empty', () {
      expect(provider.countries, isEmpty);
      expect(provider.selectedCountry, isNull);
      expect(provider.isLoading, isFalse);
      expect(provider.error, isNull);
      expect(provider.searchQuery, isEmpty);
      expect(provider.selectedRegion, isNull);
    });

    test('should filter countries by search query', () {
      provider.searchCountries('fran');
      expect(provider.searchQuery, 'fran');
    });

    test('should clear filters', () {
      provider.searchCountries('test');
      provider.filterByRegion('Europe');

      expect(provider.searchQuery, 'test');
      expect(provider.selectedRegion, 'Europe');

      provider.clearFilters();

      expect(provider.searchQuery, isEmpty);
      expect(provider.selectedRegion, isNull);
    });

    test('should filter by region', () {
      provider.filterByRegion('Europe');
      expect(provider.selectedRegion, 'Europe');

      provider.filterByRegion(null);
      expect(provider.selectedRegion, isNull);
    });
  });

  group('CountryProvider Integration Tests', () {
    test('should handle search query changes', () {
      provider.searchCountries('fran');
      expect(provider.searchQuery, 'fran');

      provider.searchCountries('');
      expect(provider.searchQuery, isEmpty);
    });

    test('should handle region filter changes', () {
      provider.filterByRegion('Europe');
      expect(provider.selectedRegion, 'Europe');

      provider.filterByRegion('Asia');
      expect(provider.selectedRegion, 'Asia');

      provider.filterByRegion(null);
      expect(provider.selectedRegion, isNull);
    });

    test('should clear selected country', () {
      provider.clearSelectedCountry();
      expect(provider.selectedCountry, isNull);
    });
  });
}
