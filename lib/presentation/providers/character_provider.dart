import 'package:flutter/material.dart';
import '../../domain/entities/character.dart';
import '../../domain/usecases/get_all_characters.dart';
import '../../domain/usecases/get_characters_by_house.dart';

class CharacterProvider extends ChangeNotifier {
  final GetAllCharacters _getAllCharacters;
  final GetCharactersByHouse _getCharactersByHouse;

  CharacterProvider({
    required GetAllCharacters getAllCharacters,
    required GetCharactersByHouse getCharactersByHouse,
  }) : _getAllCharacters = getAllCharacters,
       _getCharactersByHouse = getCharactersByHouse;

  bool _isLoading = false;
  List<Character> _characters = <Character>[];
  String? _errorMessage;
  String? _selectedHouse;

  bool get isLoading => _isLoading;
  List<Character> get characters => _characters;
  String? get errorMessage => _errorMessage;
  String? get selectedHouse => _selectedHouse;

  Future<void> fetchCharacters() async {
    _isLoading = true;
    _selectedHouse = null;
    notifyListeners();

    try {
      _characters = await _getAllCharacters.call();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = 'Erro ao carregar personagens: ${e.toString()}';
      _characters = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchCharactersByHouse(String house) async {
    if (_selectedHouse == house) return;

    _isLoading = true;
    _selectedHouse = house;
    notifyListeners();

    try {
      _characters = await _getCharactersByHouse.call(house);
      _errorMessage = null;
    } catch (e) {
      _errorMessage =
          'Erro ao carregar personagens da casa $house: ${e.toString()}';
      _characters = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> clearFilter() async {
    await fetchCharacters();
  }
}
