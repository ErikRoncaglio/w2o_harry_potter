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
      // Tentativa de buscar dados remotos (offline-first strategy)
      final remoteCharacters = await remoteDataSource.getCharacters();

      // Salva os dados no cache local
      await localDataSource.saveCharacters(remoteCharacters);

      // Converte os models para entities e retorna
      return remoteCharacters.map((model) => model.toEntity()).toList();
    } catch (e) {
      // Em caso de falha na requisição remota, busca dados do cache local
      try {
        final localCharacters = await localDataSource.getCharacters();

        // Converte os models para entities e retorna
        return localCharacters.map((model) => model.toEntity()).toList();
      } catch (localError) {
        // Se também falhar ao buscar dados locais, propaga a exceção
        throw Exception('Failed to fetch characters from both remote and local sources: $localError');
      }
    }
  }

  @override
  Future<List<Character>> getCharactersByHouse(String house) async {
    try {
      // Tentativa de buscar dados remotos filtrados por casa
      final remoteCharacters = await remoteDataSource.getCharactersByHouse(house);

      // Converte os models para entities e retorna
      return remoteCharacters.map((model) => model.toEntity()).toList();
    } catch (e) {
      // Em caso de falha na requisição remota, busca todos os dados do cache local e filtra
      try {
        final localCharacters = await localDataSource.getCharacters();

        // Filtra os personagens por casa localmente
        final filteredCharacters = localCharacters
            .where((character) =>
                character.house?.toLowerCase() == house.toLowerCase())
            .toList();

        // Converte os models para entities e retorna
        return filteredCharacters.map((model) => model.toEntity()).toList();
      } catch (localError) {
        throw Exception('Failed to fetch characters for house $house from both remote and local sources: $localError');
      }
    }
  }
}
