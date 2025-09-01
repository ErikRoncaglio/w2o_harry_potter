import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:w2o_harry_potter/core/theme/app_theme.dart';
import '../../domain/entities/character.dart';
import '../pages/character_detail_page.dart';

class CharacterListItem extends StatelessWidget {
  final Character character;

  const CharacterListItem({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CharacterDetailPage(character: character),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              width: 60,
              height: 60,
              child: Hero(
                tag: 'character_${character.id}',
                child:
                    character.image != null && character.image!.isNotEmpty
                        ? Image.network(
                          character.image!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color:
                                  Theme.of(context).colorScheme.surfaceVariant,
                              child: Icon(
                                Icons.person,
                                color:
                                    Theme.of(
                                      context,
                                    ).colorScheme.onSurfaceVariant,
                                size: 30,
                              ),
                            );
                          },
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(
                              color:
                                  Theme.of(context).colorScheme.surfaceVariant,
                              child: Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            );
                          },
                        )
                        : Container(
                          color: Theme.of(context).colorScheme.surfaceVariant,
                          child: Icon(
                            Icons.person,
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                            size: 30,
                          ),
                        ),
              ),
            ),
          ),
          title: Text(
            character.name,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (character.house != null && character.house!.isNotEmpty)
                Text(
                  _getLocalizedHouse(l10n, character.house!),
                  style: TextStyle(
                    color: _getHouseColor(context, character.house!),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              if (character.actor != null && character.actor!.isNotEmpty)
                Text(
                  '${l10n.actor}: ${character.actor}',
                  style: TextStyle(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
            ],
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: Theme.of(context).colorScheme.primary,
            size: 16,
          ),
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

  Color _getHouseColor(BuildContext context, String house) {
    final theme = Theme.of(context);

    switch (house.toLowerCase()) {
      case 'gryffindor':
        return theme.gryffindorColor;
      case 'slytherin':
        return theme.slytherinColor;
      case 'ravenclaw':
        return theme.ravenclawColor;
      case 'hufflepuff':
        return theme.hufflepuffColor;
      default:
        return theme.colorScheme.primary;
    }
  }
}
