import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../domain/entities/character.dart';
import '../../core/theme/app_theme.dart';

class CharacterDetailPage extends StatelessWidget {
  final Character character;

  const CharacterDetailPage({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.characterDetails)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                        color: theme.colorScheme.shadow.withOpacity(0.2),
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
                                return _buildImagePlaceholder(
                                  context,
                                  l10n,
                                  theme,
                                );
                              },
                            )
                            : _buildImagePlaceholder(context, l10n, theme),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            Center(
              child: Text(
                character.name,
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16),

            Center(
              child: Chip(
                backgroundColor:
                    character.alive
                        ? Colors.green.withOpacity(0.2)
                        : Colors.red.withOpacity(0.2),
                label: Text(
                  character.alive ? l10n.alive : l10n.dead,
                  style: TextStyle(
                    color:
                        character.alive ? Colors.green[700] : Colors.red[700],
                    fontWeight: FontWeight.bold,
                  ),
                ),
                side: BorderSide(
                  color: character.alive ? Colors.green : Colors.red,
                  width: 1,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Nomes alternativos (se houver)
            if (character.alternateNames.isNotEmpty)
              _buildInfoCard(context, l10n, l10n.alternateNames, [
                _InfoItem(
                  label: '',
                  value: character.alternateNames.join(', '),
                ),
              ]),

            // Informações básicas
            _buildBasicInformation(context, l10n),

            // Características físicas
            _buildPhysicalCharacteristics(context, l10n),

            // Informações mágicas
            _buildMagicalInformation(context, l10n),

            // Informações de Hogwarts
            _buildHogwartsInformation(context, l10n),

            // Informações adicionais
            _buildAdditionalInformation(context, l10n),
          ],
        ),
      ),
    );
  }

  Widget _buildImagePlaceholder(
    BuildContext context,
    AppLocalizations l10n,
    ThemeData theme,
  ) {
    return Container(
      color: theme.colorScheme.surfaceVariant,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.person,
            color: theme.colorScheme.onSurfaceVariant,
            size: 80,
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              l10n.noImageAvailable,
              style: TextStyle(
                color: theme.colorScheme.onSurfaceVariant,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBasicInformation(BuildContext context, AppLocalizations l10n) {
    final items = <_InfoItem>[];

    if (character.house != null && character.house!.isNotEmpty) {
      items.add(
        _InfoItem(
          label: l10n.house,
          value: _getLocalizedHouse(l10n, character.house!),
          valueColor: _getHouseColor(character.house!),
        ),
      );
    }

    if (character.species != null && character.species!.isNotEmpty) {
      items.add(
        _InfoItem(
          label: l10n.species,
          value: _getLocalizedSpecies(l10n, character.species!),
        ),
      );
    }

    if (character.gender != null && character.gender!.isNotEmpty) {
      items.add(
        _InfoItem(
          label: l10n.gender,
          value: _getLocalizedGender(l10n, character.gender!),
        ),
      );
    }

    if (character.dateOfBirth != null && character.dateOfBirth!.isNotEmpty) {
      items.add(
        _InfoItem(label: l10n.dateOfBirth, value: character.dateOfBirth!),
      );
    }

    if (character.yearOfBirth != null) {
      items.add(
        _InfoItem(
          label: l10n.yearOfBirth,
          value: character.yearOfBirth.toString(),
        ),
      );
    }

    if (character.ancestry != null && character.ancestry!.isNotEmpty) {
      items.add(
        _InfoItem(
          label: l10n.ancestry,
          value: _getLocalizedAncestry(l10n, character.ancestry!),
        ),
      );
    }

    if (items.isNotEmpty) {
      return _buildInfoCard(context, l10n, l10n.basicInformation, items);
    }
    return const SizedBox.shrink();
  }

  Widget _buildPhysicalCharacteristics(
    BuildContext context,
    AppLocalizations l10n,
  ) {
    final items = <_InfoItem>[];

    if (character.eyeColour != null && character.eyeColour!.isNotEmpty) {
      items.add(_InfoItem(label: l10n.eyeColour, value: character.eyeColour!));
    }

    if (character.hairColour != null && character.hairColour!.isNotEmpty) {
      items.add(
        _InfoItem(label: l10n.hairColour, value: character.hairColour!),
      );
    }

    if (items.isNotEmpty) {
      return _buildInfoCard(context, l10n, l10n.physicalCharacteristics, items);
    }
    return const SizedBox.shrink();
  }

  Widget _buildMagicalInformation(BuildContext context, AppLocalizations l10n) {
    final items = <_InfoItem>[];

    items.add(
      _InfoItem(
        label: l10n.wizard,
        value: character.wizard ? l10n.yes : l10n.no,
      ),
    );

    if (character.patronus != null && character.patronus!.isNotEmpty) {
      items.add(_InfoItem(label: l10n.patronus, value: character.patronus!));
    }

    if (character.wandWood != null ||
        character.wandCore != null ||
        character.wandLength != null) {
      final wandInfo = <String>[];

      if (character.wandWood != null && character.wandWood!.isNotEmpty) {
        wandInfo.add('${l10n.wandWood}: ${character.wandWood}');
      }

      if (character.wandCore != null && character.wandCore!.isNotEmpty) {
        wandInfo.add('${l10n.wandCore}: ${character.wandCore}');
      }

      if (character.wandLength != null) {
        wandInfo.add(
          '${l10n.wandLength}: ${character.wandLength} ${l10n.inches}',
        );
      }

      if (wandInfo.isNotEmpty) {
        items.add(_InfoItem(label: l10n.wand, value: wandInfo.join('\n')));
      }
    }

    if (items.isNotEmpty) {
      return _buildInfoCard(context, l10n, l10n.magicalInformation, items);
    }
    return const SizedBox.shrink();
  }

  Widget _buildHogwartsInformation(
    BuildContext context,
    AppLocalizations l10n,
  ) {
    final items = <_InfoItem>[];

    items.add(
      _InfoItem(
        label: l10n.hogwartsStudent,
        value: character.hogwartsStudent ? l10n.yes : l10n.no,
      ),
    );

    items.add(
      _InfoItem(
        label: l10n.hogwartsStaff,
        value: character.hogwartsStaff ? l10n.yes : l10n.no,
      ),
    );

    return _buildInfoCard(context, l10n, l10n.hogwartsInformation, items);
  }

  Widget _buildAdditionalInformation(
    BuildContext context,
    AppLocalizations l10n,
  ) {
    final items = <_InfoItem>[];

    if (character.actor != null && character.actor!.isNotEmpty) {
      items.add(_InfoItem(label: l10n.actor, value: character.actor!));
    }

    if (character.alternateActors.isNotEmpty) {
      items.add(
        _InfoItem(
          label: l10n.alternateActors,
          value: character.alternateActors.join(', '),
        ),
      );
    }

    if (items.isNotEmpty) {
      return _buildInfoCard(context, l10n, l10n.additionalInformation, items);
    }
    return const SizedBox.shrink();
  }

  Widget _buildInfoCard(
    BuildContext context,
    AppLocalizations l10n,
    String title,
    List<_InfoItem> items,
  ) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...items.map((item) => _buildInfoRow(context, item)),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, _InfoItem item) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child:
          item.label.isEmpty
              ? Text(
                item.value,
                style: TextStyle(
                  color:
                      item.valueColor ??
                      theme.colorScheme.onSurface.withOpacity(0.8),
                  fontStyle: FontStyle.italic,
                ),
              )
              : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 120,
                    child: Text(
                      '${item.label}:',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      item.value,
                      style: TextStyle(
                        color:
                            item.valueColor ??
                            theme.colorScheme.onSurface.withOpacity(0.8),
                      ),
                    ),
                  ),
                ],
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

  String _getLocalizedSpecies(AppLocalizations l10n, String species) {
    switch (species.toLowerCase()) {
      case 'human':
        return l10n.human;
      case 'half-giant':
        return l10n.halfGiant;
      case 'werewolf':
        return l10n.werewolf;
      case 'ghost':
        return l10n.ghost;
      case 'centaur':
        return l10n.centaur;
      case 'house-elf':
        return l10n.houseElf;
      case 'goblin':
        return l10n.goblin;
      case 'dragon':
        return l10n.dragon;
      case 'acromantula':
        return l10n.acromantula;
      case 'hippogriff':
        return l10n.hippogriff;
      case 'phoenix':
        return l10n.phoenix;
      case 'cat':
        return l10n.cat;
      case 'troll':
        return l10n.troll;
      case 'vampire':
        return l10n.vampire;
      case 'giant':
        return l10n.giant;
      case 'poltergeist':
        return l10n.poltergeist;
      default:
        return species;
    }
  }

  String _getLocalizedGender(AppLocalizations l10n, String gender) {
    switch (gender.toLowerCase()) {
      case 'male':
        return l10n.male;
      case 'female':
        return l10n.female;
      default:
        return gender;
    }
  }

  String _getLocalizedAncestry(AppLocalizations l10n, String ancestry) {
    switch (ancestry.toLowerCase()) {
      case 'pure-blood':
        return l10n.pureBlood;
      case 'half-blood':
        return l10n.halfBlood;
      case 'muggle-born':
        return l10n.muggleBorn;
      case 'squib':
        return l10n.squib;
      case 'muggle':
        return l10n.muggle;
      default:
        return ancestry;
    }
  }

  Color _getHouseColor(String house) {
    switch (house.toLowerCase()) {
      case 'gryffindor':
        return AppTheme.gryffindorRed;
      case 'slytherin':
        return AppTheme.slytherinGreen;
      case 'ravenclaw':
        return AppTheme.ravenclawBlue;
      case 'hufflepuff':
        return AppTheme.hufflepuffYellow;
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
