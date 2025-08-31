import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  static const String _themeModeKey = 'theme_mode';
  static const String _localeKey = 'locale';

  ThemeMode _themeMode = ThemeMode.system;
  Locale _locale = const Locale('pt', 'BR');

  ThemeMode get themeMode => _themeMode;
  Locale get locale => _locale;

  SettingsProvider() {
    loadSettings();
  }

  Future<void> loadSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Carregar tema
      final themeModeString = prefs.getString(_themeModeKey);
      if (themeModeString != null) {
        _themeMode = ThemeMode.values.firstWhere(
          (mode) => mode.toString() == themeModeString,
          orElse: () => ThemeMode.system,
        );
      }

      // Carregar idioma
      final localeString = prefs.getString(_localeKey);
      if (localeString != null) {
        if (localeString == 'en') {
          _locale = const Locale('en', 'US');
        } else {
          _locale = const Locale('pt', 'BR');
        }
      }

      notifyListeners();
    } catch (e) {
      // Em caso de erro, usar valores padrão
      debugPrint('Erro ao carregar configurações: $e');
    }
  }

  Future<void> updateThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    await _saveSettings();
    notifyListeners();
  }

  Future<void> updateLocale(String languageCode) async {
    if (languageCode == 'en') {
      _locale = const Locale('en', 'US');
    } else {
      _locale = const Locale('pt', 'BR');
    }
    await _saveSettings();
    notifyListeners();
  }

  Future<void> _saveSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_themeModeKey, _themeMode.toString());
      await prefs.setString(_localeKey, _locale.languageCode);
    } catch (e) {
      debugPrint('Erro ao salvar configurações: $e');
    }
  }
}
