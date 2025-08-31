import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../providers/settings_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsTitle)),
      body: Consumer<SettingsProvider>(
        builder: (context, settingsProvider, child) {
          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              // Seção de Aparência
              _buildSectionHeader(context, l10n.appearanceSection),
              const SizedBox(height: 8),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.theme,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),
                      _buildThemeSelector(context, settingsProvider, l10n),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Seção de Idioma
              _buildSectionHeader(context, l10n.languageSection),
              const SizedBox(height: 8),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.language,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),
                      _buildLanguageSelector(context, settingsProvider, l10n),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Seção Sobre
              _buildSectionHeader(context, l10n.aboutSection),
              const SizedBox(height: 8),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Icon(
                          Icons.info_outline,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        title: Text(l10n.version),
                        subtitle: const Text('1.0.0'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }

  Widget _buildThemeSelector(
    BuildContext context,
    SettingsProvider settingsProvider,
    AppLocalizations l10n,
  ) {
    return Column(
      children: [
        RadioListTile<ThemeMode>(
          contentPadding: EdgeInsets.zero,
          title: Text(l10n.themeSystem),
          subtitle: Text('Seguir configuração do sistema'),
          value: ThemeMode.system,
          groupValue: settingsProvider.themeMode,
          onChanged: (value) {
            if (value != null) {
              settingsProvider.updateThemeMode(value);
            }
          },
        ),
        RadioListTile<ThemeMode>(
          contentPadding: EdgeInsets.zero,
          title: Text(l10n.themeLight),
          subtitle: Text('Tema claro'),
          value: ThemeMode.light,
          groupValue: settingsProvider.themeMode,
          onChanged: (value) {
            if (value != null) {
              settingsProvider.updateThemeMode(value);
            }
          },
        ),
        RadioListTile<ThemeMode>(
          contentPadding: EdgeInsets.zero,
          title: Text(l10n.themeDark),
          subtitle: Text('Tema escuro'),
          value: ThemeMode.dark,
          groupValue: settingsProvider.themeMode,
          onChanged: (value) {
            if (value != null) {
              settingsProvider.updateThemeMode(value);
            }
          },
        ),
      ],
    );
  }

  Widget _buildLanguageSelector(
    BuildContext context,
    SettingsProvider settingsProvider,
    AppLocalizations l10n,
  ) {
    return Column(
      children: [
        RadioListTile<String>(
          contentPadding: EdgeInsets.zero,
          title: Text(l10n.languagePortuguese),
          subtitle: const Text('Português (Brasil)'),
          value: 'pt',
          groupValue: settingsProvider.locale.languageCode,
          onChanged: (value) {
            if (value != null) {
              settingsProvider.updateLocale(value);
            }
          },
        ),
        RadioListTile<String>(
          contentPadding: EdgeInsets.zero,
          title: Text(l10n.languageEnglish),
          subtitle: const Text('English (United States)'),
          value: 'en',
          groupValue: settingsProvider.locale.languageCode,
          onChanged: (value) {
            if (value != null) {
              settingsProvider.updateLocale(value);
            }
          },
        ),
      ],
    );
  }
}
