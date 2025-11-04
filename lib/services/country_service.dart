import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/country.dart';

class CountryService {
  static const String baseUrl = 'https://restcountries.com/v3.1';

  Future<List<Country>> getAllCountries() async {
    try {
      final response = await http
          .get(
            Uri.parse('$baseUrl/all'),
            headers: {'Accept': 'application/json'},
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Country.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load countries: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching countries: $e');
    }
  }

  Future<Country?> getCountryByName(String name) async {
    try {
      final response = await http
          .get(
            Uri.parse('$baseUrl/name/$name'),
            headers: {'Accept': 'application/json'},
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        if (data.isNotEmpty) {
          return Country.fromJson(data.first);
        }
      }
      return null;
    } catch (e) {
      throw Exception('Error fetching country: $e');
    }
  }

  Future<List<Country>> searchCountries(String query) async {
    try {
      final response = await http
          .get(
            Uri.parse('$baseUrl/name/$query'),
            headers: {'Accept': 'application/json'},
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Country.fromJson(json)).toList();
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<List<Country>> getCountriesByRegion(String region) async {
    try {
      final response = await http
          .get(
            Uri.parse('$baseUrl/region/$region'),
            headers: {'Accept': 'application/json'},
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Country.fromJson(json)).toList();
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
