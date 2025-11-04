class Country {
  final String name;
  final String capital;
  final String region;
  final String subregion;
  final int population;
  final String flag;
  final String flagEmoji;
  final List<String> languages;
  final List<String> currencies;
  final double? area;
  final List<String> borders;
  final String code;

  Country({
    required this.name,
    required this.capital,
    required this.region,
    required this.subregion,
    required this.population,
    required this.flag,
    required this.flagEmoji,
    required this.languages,
    required this.currencies,
    this.area,
    required this.borders,
    required this.code,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name']?['common'] ?? json['name'] ?? 'Unknown',
      capital: (json['capital'] as List?)?.first ?? 'N/A',
      region: json['region'] ?? 'Unknown',
      subregion: json['subregion'] ?? 'Unknown',
      population: json['population'] ?? 0,
      flag: json['flags']?['png'] ?? json['flags']?['svg'] ?? '',
      flagEmoji: json['flag'] ?? '🏳️',
      languages: json['languages'] != null
          ? (json['languages'] as Map).values.map((e) => e.toString()).toList()
          : [],
      currencies: json['currencies'] != null
          ? (json['currencies'] as Map).keys.map((e) => e.toString()).toList()
          : [],
      area: json['area']?.toDouble(),
      borders: json['borders'] != null
          ? (json['borders'] as List).map((e) => e.toString()).toList()
          : [],
      code: json['cca2'] ?? json['alpha2Code'] ?? '',
    );
  }

  String get formattedPopulation {
    if (population >= 1000000000) {
      return '${(population / 1000000000).toStringAsFixed(1)}B';
    } else if (population >= 1000000) {
      return '${(population / 1000000).toStringAsFixed(1)}M';
    } else if (population >= 1000) {
      return '${(population / 1000).toStringAsFixed(1)}K';
    }
    return population.toString();
  }

  String get formattedArea {
    if (area == null) return 'N/A';
    if (area! >= 1000000) {
      return '${(area! / 1000000).toStringAsFixed(1)}M km²';
    } else if (area! >= 1000) {
      return '${(area! / 1000).toStringAsFixed(1)}K km²';
    }
    return '${area!.toStringAsFixed(0)} km²';
  }
}
