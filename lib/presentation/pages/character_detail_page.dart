import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../domain/entities/character.dart';

class CharacterDetailPage extends StatelessWidget {
  final Character character;

  const CharacterDetailPage({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.characterDetails)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagem do personagem em destaque
            Center(
              child: Hero(
                tag: 'character_${character.id}',
                child: Container(
                  width: 200,
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(
                          context,
                        ).colorScheme.shadow.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child:
                        character.image != null && character.image!.isNotEmpty
                            ? Image.network(
                              character.image!,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color:
                                      Theme.of(
                                        context,
                                      ).colorScheme.surfaceVariant,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.person,
                                        color:
                                            Theme.of(
                                              context,
                                            ).colorScheme.onSurfaceVariant,
                                        size: 80,
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        l10n.noImageAvailable,
                                        style: TextStyle(
                                          color:
                                              Theme.of(
                                                context,
                                              ).colorScheme.onSurfaceVariant,
                                          fontSize: 12,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            )
                            : Container(
                              color:
                                  Theme.of(context).colorScheme.surfaceVariant,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.person,
                                    color:
                                        Theme.of(
                                          context,
                                        ).colorScheme.onSurfaceVariant,
                                    size: 80,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    l10n.noImageAvailable,
                                    style: TextStyle(
                                      color:
                                          Theme.of(
                                            context,
                                          ).colorScheme.onSurfaceVariant,
                                      fontSize: 12,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Nome do personagem
            Text(
              character.name,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),

            // Informações básicas
            if (character.house != null && character.house!.isNotEmpty ||
                character.actor != null && character.actor!.isNotEmpty)
              _buildInfoCard(context, l10n, 'Informações Básicas', [
                if (character.house != null && character.house!.isNotEmpty)
                  _InfoItem(
                    label: l10n.house,
                    value: _getLocalizedHouse(l10n, character.house!),
                    valueColor: _getHouseColor(character.house!),
                  ),
                if (character.actor != null && character.actor!.isNotEmpty)
                  _InfoItem(label: l10n.actor, value: character.actor!),
              ]),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context,
    AppLocalizations l10n,
    String title,
    List<_InfoItem> items,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 12),
            ...items.map(
              (item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 100,
                      child: Text(
                        '${item.label}:',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        item.value,
                        style: TextStyle(
                          color:
                              item.valueColor ??
                              Theme.of(
                                context,
                              ).colorScheme.onSurface.withOpacity(0.8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getLocalizedHouse(AppLocalizations l10n, String house) {
    switch (house.toLowerCase()) {
      case 'gryffindor':
        return l10n.gryffindor;
      case 'slytherin':
        return l10n.slytherin;
      case 'ravenclaw':
        return l10n.ravenclaw;
      case 'hufflepuff':
        return l10n.hufflepuff;
      default:
        return house;
    }
  }

  Color _getHouseColor(String house) {
    switch (house.toLowerCase()) {
      case 'gryffindor':
        return const Color(0xFF740001); // Gryffindor Red
      case 'slytherin':
        return const Color(0xFF1A472A); // Slytherin Green
      case 'ravenclaw':
        return const Color(0xFF0E1A40); // Ravenclaw Blue
      case 'hufflepuff':
        return const Color(0xFFECB939); // Hufflepuff Yellow
      default:
        return Colors.grey;
    }
  }
}

class _InfoItem {
  final String label;
  final String value;
  final Color? valueColor;

  _InfoItem({required this.label, required this.value, this.valueColor});
}
