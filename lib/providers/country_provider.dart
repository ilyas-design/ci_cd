import 'package:flutter/foundation.dart';
import '../models/country.dart';
import '../services/country_service.dart';

class CountryProvider with ChangeNotifier {
  final CountryService _service = CountryService();

  List<Country> _countries = [];
  List<Country> _filteredCountries = [];
  Country? _selectedCountry;
  bool _isLoading = false;
  String? _error;
  String _searchQuery = '';
  String? _selectedRegion;

  List<Country> get countries => _filteredCountries;
  Country? get selectedCountry => _selectedCountry;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String get searchQuery => _searchQuery;
  String? get selectedRegion => _selectedRegion;

  List<String> get availableRegions {
    final regions = _countries.map((c) => c.region).toSet().toList();
    regions.sort();
    return regions;
  }

  Future<void> loadCountries() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _countries = await _service.getAllCountries();
      _countries.sort((a, b) => a.name.compareTo(b.name));
      _filteredCountries = _countries;
      _error = null;
    } catch (e) {
      _error = e.toString();
      _countries = [];
      _filteredCountries = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void searchCountries(String query) {
    _searchQuery = query;
    _applyFilters();
  }

  void filterByRegion(String? region) {
    _selectedRegion = region;
    _applyFilters();
  }

  void _applyFilters() {
    List<Country> filtered = List.from(_countries);

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((country) {
        final query = _searchQuery.toLowerCase();
        return country.name.toLowerCase().contains(query) ||
            country.capital.toLowerCase().contains(query);
      }).toList();
    }

    // Apply region filter
    if (_selectedRegion != null && _selectedRegion!.isNotEmpty) {
      filtered = filtered.where((country) {
        return country.region == _selectedRegion;
      }).toList();
    }

    _filteredCountries = filtered;
    notifyListeners();
  }

  void clearFilters() {
    _searchQuery = '';
    _selectedRegion = null;
    _filteredCountries = _countries;
    notifyListeners();
  }

  Future<void> loadCountryDetails(String name) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _selectedCountry = await _service.getCountryByName(name);
      if (_selectedCountry == null) {
        _error = 'Country not found';
      }
    } catch (e) {
      _error = e.toString();
      _selectedCountry = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearSelectedCountry() {
    _selectedCountry = null;
    notifyListeners();
  }
}
