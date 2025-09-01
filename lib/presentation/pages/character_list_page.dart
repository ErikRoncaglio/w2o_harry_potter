import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:w2o_harry_potter/core/theme/app_theme.dart';
import '../providers/character_provider.dart';
import '../widgets/character_list_item.dart';

class CharacterListPage extends StatefulWidget {
  const CharacterListPage({super.key});

  @override
  State<CharacterListPage> createState() => _CharacterListPageState();
}

class _CharacterListPageState extends State<CharacterListPage> {
  late List<String> _houses;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<CharacterProvider>();
      if (provider.selectedHouse != null) {
        provider.fetchCharactersByHouse(provider.selectedHouse!);
      } else {
        provider.fetchCharacters();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    _houses = ['gryffindor', 'slytherin', 'ravenclaw', 'hufflepuff',];

    return Scaffold(
      body: Column(
        children: [
          _buildHouseFilter(l10n),
          Expanded(
            child: Consumer<CharacterProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          l10n.loading,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                      ],
                    ).animate().fadeIn(duration: 300.ms).scale(delay: 100.ms),
                  );
                }

                if (provider.errorMessage != null) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 64,
                          color: Theme.of(context).colorScheme.error,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          provider.errorMessage!,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            if (provider.selectedHouse != null) {
                              provider.fetchCharactersByHouse(
                                provider.selectedHouse!,
                              );
                            } else {
                              provider.fetchCharacters();
                            }
                          },
                          child: Text(l10n.retryLoad),
                        ),
                      ],
                    ).animate().fadeIn(duration: 300.ms),
                  );
                }

                if (provider.characters.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.people_outline,
                          size: 64,
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withOpacity(0.5),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          l10n.noCharactersFound,
                          style: TextStyle(
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurface.withOpacity(0.7),
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ).animate().fadeIn(duration: 300.ms),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: provider.characters.length,
                  itemBuilder: (context, index) {
                    return CharacterListItem(
                          character: provider.characters[index],
                        )
                        .animate()
                        .fadeIn(delay: 60.ms)
                        .slideX(begin: 0.1, delay: 60.ms);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHouseFilter(AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.filterByHouse,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Consumer<CharacterProvider>(
            builder: (context, provider, child) {
              return Wrap(
                spacing: 8.0,
                children: [
                  FilterChip(
                    label: Text(l10n.allHouses),
                    selected: provider.selectedHouse == null,
                    onSelected: (selected) {
                      if (selected) {
                        // provider.clearHouseFilter();
                        provider.fetchCharacters();
                      }
                    },
                    selectedColor: Theme.of(
                      context,
                    ).colorScheme.primary.withOpacity(0.2),
                    checkmarkColor: Theme.of(context).colorScheme.primary,
                  ),
                  ..._houses.map((house) {
                    return FilterChip(
                      label: Text(_getHouseLabel(house)),
                      selected: provider.selectedHouse == house,
                      onSelected: (selected) {
                        if (selected) {
                          provider.fetchCharactersByHouse(house);
                        }
                      },
                      selectedColor: _getHouseColor(house).withOpacity(0.2),
                      checkmarkColor: _getHouseColor(house),
                    );
                  }).toList(),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  String _getHouseLabel(String houseKey) {
    switch (houseKey) {
      case 'gryffindor':
        return AppLocalizations.of(context)!.gryffindor;
      case 'slytherin':
        return AppLocalizations.of(context)!.slytherin;
      case 'ravenclaw':
        return AppLocalizations.of(context)!.ravenclaw;
      case 'hufflepuff':
        return AppLocalizations.of(context)!.hufflepuff;
      default:
        return houseKey;
    }
  }

  Color _getHouseColor(String houseKey) {
    final theme = Theme.of(context);

    switch (houseKey) {
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
