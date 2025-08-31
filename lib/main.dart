import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'data/models/character_model.dart';
import 'data/models/spell_model.dart';
import 'core/injection/dependency_injection.dart' as di;
import 'presentation/providers/character_provider.dart';
import 'presentation/providers/spell_provider.dart';
import 'presentation/providers/settings_provider.dart';
import 'presentation/pages/home_page.dart';
import 'domain/usecases/get_all_characters.dart';
import 'domain/usecases/get_characters_by_house.dart';
import 'domain/usecases/get_all_spells.dart';

void main() async {
  // Garante que os widgets do Flutter estão inicializados
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa o Hive para o armazenamento local
  await Hive.initFlutter();

  // Registra os adaptadores do Hive
  Hive.registerAdapter(WandModelAdapter());
  Hive.registerAdapter(CharacterModelAdapter());
  Hive.registerAdapter(SpellModelAdapter());

  // Inicializa a injeção de dependências
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => di.sl<SettingsProvider>()),
        ChangeNotifierProvider(
          create:
              (context) => CharacterProvider(
                getAllCharacters: di.sl<GetAllCharacters>(),
                getCharactersByHouse: di.sl<GetCharactersByHouse>(),
              ),
        ),
        ChangeNotifierProvider(
          create:
              (context) => SpellProvider(getAllSpells: di.sl<GetAllSpells>()),
        ),
      ],
      child: Consumer<SettingsProvider>(
        builder: (context, settingsProvider, child) {
          return MaterialApp(
            title: 'Mundo Bruxo',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: settingsProvider.themeMode,
            locale: settingsProvider.locale,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: const HomePage(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
