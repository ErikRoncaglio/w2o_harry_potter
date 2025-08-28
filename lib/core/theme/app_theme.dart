import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF740001), // Gryffindor Red
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