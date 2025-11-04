import 'package:flutter/material.dart';
import '../models/country.dart';

class CountryDetailsPage extends StatelessWidget {
  final Country country;

  const CountryDetailsPage({super.key, required this.country});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                country.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: country.flag.isNotEmpty
                  ? Image.network(
                      country.flag,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Theme.of(context).colorScheme.primary,
                          child: Center(
                            child: Text(
                              country.flagEmoji,
                              style: const TextStyle(fontSize: 100),
                            ),
                          ),
                        );
                      },
                    )
                  : Container(
                      color: Theme.of(context).colorScheme.primary,
                      child: Center(
                        child: Text(
                          country.flagEmoji,
                          style: const TextStyle(fontSize: 100),
                        ),
                      ),
                    ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoCard(context, 'Basic Information', [
                    _buildInfoRow(context, 'Capital', country.capital),
                    _buildInfoRow(context, 'Region', country.region),
                    _buildInfoRow(context, 'Subregion', country.subregion),
                    _buildInfoRow(context, 'Country Code', country.code),
                  ]),
                  const SizedBox(height: 16),
                  _buildInfoCard(context, 'Statistics', [
                    _buildInfoRow(
                      context,
                      'Population',
                      country.formattedPopulation,
                      icon: Icons.people,
                    ),
                    _buildInfoRow(
                      context,
                      'Area',
                      country.formattedArea,
                      icon: Icons.map,
                    ),
                  ]),
                  if (country.languages.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    _buildInfoCard(context, 'Languages', [
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: country.languages.map((lang) {
                          return Chip(
                            label: Text(lang),
                            avatar: const Icon(Icons.language, size: 18),
                          );
                        }).toList(),
                      ),
                    ]),
                  ],
                  if (country.currencies.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    _buildInfoCard(context, 'Currencies', [
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: country.currencies.map((currency) {
                          return Chip(
                            label: Text(currency),
                            avatar: const Icon(Icons.attach_money, size: 18),
                          );
                        }).toList(),
                      ),
                    ]),
                  ],
                  if (country.borders.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    _buildInfoCard(context, 'Bordering Countries', [
                      Text(
                        '${country.borders.length} countries',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: country.borders.map((border) {
                          return Chip(label: Text(border));
                        }).toList(),
                      ),
                    ]),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context,
    String title,
    List<Widget> children,
  ) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context,
    String label,
    String value, {
    IconData? icon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 8),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
