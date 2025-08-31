import '../entities/character.dart';
import '../repositories/character_repository.dart';

class GetCharactersByHouse {
  final CharacterRepository repository;

  GetCharactersByHouse({required this.repository});

  Future<List<Character>> call(String house) async {
    return await repository.getCharactersByHouse(house);
  }
}
