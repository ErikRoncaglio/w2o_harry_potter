import '../entities/character.dart';
import '../repositories/character_repository.dart';

class GetAllCharacters {
  final CharacterRepository repository;

  GetAllCharacters({required this.repository});

  Future<List<Character>> call() async {
    return await repository.getCharacters();
  }
}
