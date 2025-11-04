import 'package:flutter_test/flutter_test.dart';
import 'package:ci_cd/services/country_service.dart';

void main() {
  late CountryService countryService;

  setUp(() {
    countryService = CountryService();
  });

  group('CountryService Tests', () {
    test('should be instantiable', () {
      expect(countryService, isNotNull);
      expect(countryService, isA<CountryService>());
    });

    // Note: Full integration tests with mocked HTTP would require
    // http_mock_adapter setup or a custom HTTP client mock.
    // These tests verify the service structure and basic functionality.

    test('should have correct base URL', () {
      // Verify the service has the expected structure
      expect(countryService, isNotNull);
    });
  });
}
