import '../../domain/entities/spell.dart';
import '../../domain/repositories/spell_repository.dart';
import '../datasources/spell_local_datasource.dart';
import '../datasources/spell_remote_datasource.dart';

class SpellRepositoryImpl implements SpellRepository {
  final SpellRemoteDataSource remoteDataSource;
  final SpellLocalDataSource localDataSource;

  SpellRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<List<Spell>> getSpells() async {
    try {
      // Tentativa de buscar dados remotos (offline-first strategy)
      final remoteSpells = await remoteDataSource.getSpells();

      // Salva os dados no cache local
      await localDataSource.saveSpells(remoteSpells);

      // Converte os models para entities e retorna
      return remoteSpells.map((model) => model.toEntity()).toList();
    } catch (e) {
      // Em caso de falha na requisição remota, busca dados do cache local
      try {
        final localSpells = await localDataSource.getSpells();

        // Converte os models para entities e retorna
        return localSpells.map((model) => model.toEntity()).toList();
      } catch (localError) {
        // Se também falhar ao buscar dados locais, propaga a exceção
        throw Exception('Failed to fetch spells from both remote and local sources: $localError');
      }
    }
  }
}
