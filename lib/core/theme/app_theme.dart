import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Cores do Harry Potter
  static const Color gryffindorRed = Color(0xFF740001);
  static const Color gryffindorGold = Color(0xFFD3A625);
  static const Color slytherinGreen = Color(0xFF1A472A);
  static const Color slytherinSilver = Color(0xFFAAAAAA);
  static const Color ravenclawBlue = Color(0xFF0E1A40);
  static const Color hufflepuffYellow = Color(0xFFECB939);
  static const Color parchmentLight = Color(0xFFF4F1E8);
  static const Color parchmentDark = Color(0xFFE8E0D1);
  static const Color darkWood = Color(0xFF2C1810);
  static const Color oldPaper = Color(0xFFF9F6F0);

  static final ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.light(
      primary: gryffindorRed,
      onPrimary: Colors.white,
      brightness: Brightness.light,
    ),
    textTheme:
        GoogleFonts.latoTextTheme(), // Uma fonte legível para o corpo do texto
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(
        fontFamily: 'Harry P', // Nossa fonte customizada local!
        fontSize: 32,
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF1A472A), // Slytherin Green
      brightness: Brightness.dark,
    ),
    textTheme: GoogleFonts.latoTextTheme(
      ThemeData(brightness: Brightness.dark).textTheme,
    ),
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(
        fontFamily: 'Harry P', // Nossa fonte customizada local!
        fontSize: 32,
        color: Colors.white, // Cor para tema escuro
      ),
    ),
  );
}
