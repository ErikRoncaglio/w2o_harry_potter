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
      final remoteSpells = await remoteDataSource.getSpells();

      await localDataSource.saveSpells(remoteSpells);

      return remoteSpells.map((model) => model.toEntity()).toList();
    } catch (e) {
      try {
        final localSpells = await localDataSource.getSpells();

        return localSpells.map((model) => model.toEntity()).toList();
      } catch (localError) {
        throw Exception('Failed to fetch spells from both remote and local sources: $localError');
      }
    }
  }
}
