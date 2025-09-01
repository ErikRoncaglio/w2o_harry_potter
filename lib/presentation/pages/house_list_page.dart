import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../providers/character_provider.dart';
import '../../core/theme/app_theme.dart';

class HouseListPage extends StatelessWidget {
  final VoidCallback? onNavigateToCharacters;

  const HouseListPage({super.key, this.onNavigateToCharacters});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.chooseHouseToSeeMembers,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onBackground,
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
                    'gryffindor',
                    l10n.gryffindorDescription,
                    theme.gryffindorColor,
                    Icons.local_fire_department,
                    0,
                  ),
                  _buildHouseCard(
                    context,
                    l10n,
                    'slytherin',
                    l10n.slytherinDescription,
                    theme.slytherinColor,
                    Icons.psychology,
                    1,
                  ),
                  _buildHouseCard(
                    context,
                    l10n,
                    'ravenclaw',
                    l10n.ravenclawDescription,
                    theme.ravenclawColor,
                    Icons.school,
                    2,
                  ),
                  _buildHouseCard(
                    context,
                    l10n,
                    'hufflepuff',
                    l10n.hufflepuffDescription,
                    theme.hufflepuffColor,
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
    final theme = Theme.of(context);

    return Card(
      elevation: 4,
      child: InkWell(
        onTap: () {
          final provider = context.read<CharacterProvider>();
          provider.fetchCharactersByHouse(houseKey);

          onNavigateToCharacters?.call();
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
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.7),
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
