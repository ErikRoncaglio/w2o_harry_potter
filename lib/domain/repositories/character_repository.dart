import '../entities/character.dart';

abstract class CharacterRepository {
  Future<List<Character>> getCharacters();
  Future<List<Character>> getCharactersByHouse(String house);
}
