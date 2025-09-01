// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

import 'package:w2o_harry_potter/main.dart';
import 'package:w2o_harry_potter/presentation/providers/settings_provider.dart';
import 'package:w2o_harry_potter/domain/usecases/get_all_characters.dart';
import 'package:w2o_harry_potter/domain/usecases/get_characters_by_house.dart';
import 'package:w2o_harry_potter/domain/usecases/get_all_spells.dart';
import 'package:w2o_harry_potter/domain/repositories/character_repository.dart';
import 'package:w2o_harry_potter/domain/repositories/spell_repository.dart';
import 'package:w2o_harry_potter/domain/entities/character.dart';
import 'package:w2o_harry_potter/domain/entities/spell.dart';

// Mock repositories para testes
class MockCharacterRepository implements CharacterRepository {
  @override
  Future<List<Character>> getCharacters() async => [];

  @override
  Future<List<Character>> getCharactersByHouse(String house) async => [];
}

class MockSpellRepository implements SpellRepository {
  @override
  Future<List<Spell>> getSpells() async => [];
}

void main() {
  setUp(() {
    // Reset GetIt instance before each test
    GetIt.instance.reset();

    // Register mock dependencies
    GetIt.instance.registerLazySingleton<CharacterRepository>(() => MockCharacterRepository());
    GetIt.instance.registerLazySingleton<SpellRepository>(() => MockSpellRepository());

    GetIt.instance.registerLazySingleton<GetAllCharacters>(() => GetAllCharacters(repository: GetIt.instance()));
    GetIt.instance.registerLazySingleton<GetCharactersByHouse>(() => GetCharactersByHouse(repository: GetIt.instance()));
    GetIt.instance.registerLazySingleton<GetAllSpells>(() => GetAllSpells(repository: GetIt.instance()));

    GetIt.instance.registerLazySingleton<SettingsProvider>(() => SettingsProvider());
  });

  tearDown(() {
    GetIt.instance.reset();
  });

  testWidgets('App should load and show bottom navigation', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    // Verify that the app loads without crashing and shows the bottom navigation
    expect(find.byType(BottomNavigationBar), findsOneWidget);

    // Verify that we can find navigation items
    expect(find.byIcon(Icons.people), findsOneWidget); // Characters tab
    expect(find.byIcon(Icons.auto_fix_high), findsOneWidget); // Spells tab
    expect(find.byIcon(Icons.settings), findsOneWidget); // Settings tab
  });
}
