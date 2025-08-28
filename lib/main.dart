import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'core/theme/app_theme.dart';

void main() async {
  // Garante que os widgets do Flutter estão inicializados
  WidgetsFlutterBinding.ensureInitialized();
  // Inicializa o Hive para o armazenamento local
  await Hive.initFlutter();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Harry Potter App', // Este título é para o sistema operacional
      // Configuração do Tema
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system, // Usa o tema do sistema (claro/escuro)
      // Configuração de Idiomas
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,

      home: const HomePage(),
    );
  }
}

// Criando uma página inicial temporária
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Usando o título traduzido!
        title: Text(AppLocalizations.of(context)!.appTitle),
      ),
      body: const Center(child: Text('Bem-vindo ao Teste!')),
    );
  }
}
