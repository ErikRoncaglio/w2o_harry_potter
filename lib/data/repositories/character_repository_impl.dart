import '../../domain/entities/character.dart';
import '../../domain/repositories/character_repository.dart';
import '../datasources/character_local_datasource.dart';
import '../datasources/character_remote_datasource.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  final CharacterRemoteDataSource remoteDataSource;
  final CharacterLocalDataSource localDataSource;

  CharacterRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<List<Character>> getCharacters() async {
    try {
      final remoteCharacters = await remoteDataSource.getCharacters();

      await localDataSource.saveCharacters(remoteCharacters);

      return remoteCharacters.map((model) => model.toEntity()).toList();
    } catch (e) {
      try {
        final localCharacters = await localDataSource.getCharacters();

        return localCharacters.map((model) => model.toEntity()).toList();
      } catch (localError) {
        throw Exception('Failed to fetch characters from both remote and local sources: $localError');
      }
    }
  }

  @override
  Future<List<Character>> getCharactersByHouse(String house) async {
    try {
      final remoteCharacters = await remoteDataSource.getCharactersByHouse(house);

      return remoteCharacters.map((model) => model.toEntity()).toList();
    } catch (e) {
      try {
        final localCharacters = await localDataSource.getCharacters();

        final filteredCharacters = localCharacters
            .where((character) =>
                character.house?.toLowerCase() == house.toLowerCase())
            .toList();

        return filteredCharacters.map((model) => model.toEntity()).toList();
      } catch (localError) {
        throw Exception('Failed to fetch characters for house $house from both remote and local sources: $localError');
      }
    }
  }
}
