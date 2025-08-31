import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../providers/character_provider.dart';

class HouseListPage extends StatelessWidget {
  const HouseListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Escolha uma casa para ver seus membros:',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.8,
                children: [
                  _buildHouseCard(
                    context,
                    l10n,
                    'Gryffindor',
                    'Coragem e bravura',
                    const Color(0xFF740001),
                    Icons.local_fire_department,
                    0,
                  ),
                  _buildHouseCard(
                    context,
                    l10n,
                    'Slytherin',
                    'Ambição e astúcia',
                    const Color(0xFF1A472A),
                    Icons.psychology,
                    1,
                  ),
                  _buildHouseCard(
                    context,
                    l10n,
                    'Ravenclaw',
                    'Inteligência e sabedoria',
                    const Color(0xFF0E1A40),
                    Icons.school,
                    2,
                  ),
                  _buildHouseCard(
                    context,
                    l10n,
                    'Hufflepuff',
                    'Lealdade e trabalho duro',
                    const Color(0xFFECB939),
                    Icons.favorite,
                    3,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHouseCard(
    BuildContext context,
    AppLocalizations l10n,
    String houseKey,
    String description,
    Color color,
    IconData icon,
    int index,
  ) {
    final houseName = _getLocalizedHouseName(l10n, houseKey);

    return Card(
      elevation: 4,
      child: InkWell(
        onTap: () {
          // Filtra personagens por casa
          final provider = context.read<CharacterProvider>();
          provider.fetchCharactersByHouse(houseKey);

          // Volta para a primeira aba (personagens)
          // Isso funciona porque a HomePage usa IndexedStack
          DefaultTabController.of(context)?.animateTo(0);
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [color.withOpacity(0.1), color.withOpacity(0.05)],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, size: 40, color: color),
                ),
                const SizedBox(height: 16),
                Text(
                  houseName,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withOpacity(0.7),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    ).animate().fadeIn(delay: (index * 100).ms).scale(delay: (index * 100).ms);
  }

  String _getLocalizedHouseName(AppLocalizations l10n, String houseKey) {
    switch (houseKey.toLowerCase()) {
      case 'gryffindor':
        return l10n.gryffindor;
      case 'slytherin':
        return l10n.slytherin;
      case 'ravenclaw':
        return l10n.ravenclaw;
      case 'hufflepuff':
        return l10n.hufflepuff;
      default:
        return houseKey;
    }
  }
}
