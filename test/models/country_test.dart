import 'package:flutter_test/flutter_test.dart';
import 'package:ci_cd/models/country.dart';

void main() {
  group('Country Model Tests', () {
    test('should create Country from valid JSON', () {
      final json = {
        'name': {'common': 'France'},
        'capital': ['Paris'],
        'region': 'Europe',
        'subregion': 'Western Europe',
        'population': 67390000,
        'flags': {
          'png': 'https://flagcdn.com/w320/fr.png',
          'svg': 'https://flagcdn.com/fr.svg',
        },
        'flag': '🇫🇷',
        'languages': {'fra': 'French'},
        'currencies': {'EUR': {}},
        'area': 551695.0,
        'borders': ['AND', 'BEL', 'DEU', 'ITA', 'LUX', 'MCO', 'ESP', 'CHE'],
        'cca2': 'FR',
      };

      final country = Country.fromJson(json);

      expect(country.name, 'France');
      expect(country.capital, 'Paris');
      expect(country.region, 'Europe');
      expect(country.subregion, 'Western Europe');
      expect(country.population, 67390000);
      expect(country.flag, 'https://flagcdn.com/w320/fr.png');
      expect(country.flagEmoji, '🇫🇷');
      expect(country.languages, ['French']);
      expect(country.currencies, ['EUR']);
      expect(country.area, 551695.0);
      expect(country.borders, [
        'AND',
        'BEL',
        'DEU',
        'ITA',
        'LUX',
        'MCO',
        'ESP',
        'CHE',
      ]);
      expect(country.code, 'FR');
    });

    test('should handle missing optional fields', () {
      final json = {
        'name': {'common': 'Test Country'},
        'capital': ['Test Capital'],
        'region': 'Test Region',
        'subregion': 'Test Subregion',
        'population': 1000000,
        'flags': {},
        'flag': '🏳️',
        'languages': {},
        'currencies': {},
        'borders': [],
        'cca2': 'TC',
      };

      final country = Country.fromJson(json);

      expect(country.name, 'Test Country');
      expect(country.flag, '');
      expect(country.languages, isEmpty);
      expect(country.currencies, isEmpty);
      expect(country.borders, isEmpty);
      expect(country.area, isNull);
    });

    test('should format population correctly', () {
      final country1 = Country(
        name: 'Test',
        capital: 'Capital',
        region: 'Region',
        subregion: 'Subregion',
        population: 1500000000,
        flag: '',
        flagEmoji: '🏳️',
        languages: [],
        currencies: [],
        borders: [],
        code: 'TC',
      );

      expect(country1.formattedPopulation, '1.5B');

      final country2 = Country(
        name: 'Test',
        capital: 'Capital',
        region: 'Region',
        subregion: 'Subregion',
        population: 5000000,
        flag: '',
        flagEmoji: '🏳️',
        languages: [],
        currencies: [],
        borders: [],
        code: 'TC',
      );

      expect(country2.formattedPopulation, '5.0M');

      final country3 = Country(
        name: 'Test',
        capital: 'Capital',
        region: 'Region',
        subregion: 'Subregion',
        population: 5000,
        flag: '',
        flagEmoji: '🏳️',
        languages: [],
        currencies: [],
        borders: [],
        code: 'TC',
      );

      expect(country3.formattedPopulation, '5.0K');
    });

    test('should format area correctly', () {
      final country1 = Country(
        name: 'Test',
        capital: 'Capital',
        region: 'Region',
        subregion: 'Subregion',
        population: 1000000,
        flag: '',
        flagEmoji: '🏳️',
        languages: [],
        currencies: [],
        area: 2000000.0,
        borders: [],
        code: 'TC',
      );

      expect(country1.formattedArea, '2.0M km²');

      final country2 = Country(
        name: 'Test',
        capital: 'Capital',
        region: 'Region',
        subregion: 'Subregion',
        population: 1000000,
        flag: '',
        flagEmoji: '🏳️',
        languages: [],
        currencies: [],
        area: 5000.0,
        borders: [],
        code: 'TC',
      );

      expect(country2.formattedArea, '5.0K km²');

      final country3 = Country(
        name: 'Test',
        capital: 'Capital',
        region: 'Region',
        subregion: 'Subregion',
        population: 1000000,
        flag: '',
        flagEmoji: '🏳️',
        languages: [],
        currencies: [],
        area: null,
        borders: [],
        code: 'TC',
      );

      expect(country3.formattedArea, 'N/A');
    });

    test('should handle empty languages and currencies', () {
      final json = {
        'name': {'common': 'Test'},
        'capital': ['Capital'],
        'region': 'Region',
        'subregion': 'Subregion',
        'population': 1000000,
        'flags': {},
        'flag': '🏳️',
        'borders': [],
        'cca2': 'TC',
      };

      final country = Country.fromJson(json);

      expect(country.languages, isEmpty);
      expect(country.currencies, isEmpty);
    });
  });
}
