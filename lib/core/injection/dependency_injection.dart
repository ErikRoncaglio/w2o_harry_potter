import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../../data/datasources/character_local_datasource.dart';
import '../../data/datasources/character_remote_datasource.dart';
import '../../data/datasources/spell_local_datasource.dart';
import '../../data/datasources/spell_remote_datasource.dart';
import '../../data/repositories/character_repository_impl.dart';
import '../../data/repositories/spell_repository_impl.dart';
import '../../domain/repositories/character_repository.dart';
import '../../domain/repositories/spell_repository.dart';
import '../../domain/usecases/get_all_characters.dart';
import '../../domain/usecases/get_characters_by_house.dart';
import '../../domain/usecases/get_all_spells.dart';
import '../../presentation/providers/settings_provider.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External dependencies
  sl.registerLazySingleton<Dio>(() => Dio());

  // Character Data sources
  sl.registerLazySingleton<CharacterRemoteDataSource>(
    () => CharacterRemoteDataSourceImpl(dio: sl()),
  );

  sl.registerLazySingleton<CharacterLocalDataSource>(
    () => CharacterLocalDataSourceImpl(),
  );

  // Spell Data sources
  sl.registerLazySingleton<SpellRemoteDataSource>(
    () => SpellRemoteDataSourceImpl(dio: sl()),
  );

  sl.registerLazySingleton<SpellLocalDataSource>(
    () => SpellLocalDataSourceImpl(),
  );

  // Repositories
  sl.registerLazySingleton<CharacterRepository>(
    () =>
        CharacterRepositoryImpl(remoteDataSource: sl(), localDataSource: sl()),
  );

  sl.registerLazySingleton<SpellRepository>(
    () => SpellRepositoryImpl(remoteDataSource: sl(), localDataSource: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetAllCharacters(repository: sl()));
  sl.registerLazySingleton(() => GetCharactersByHouse(repository: sl()));
  sl.registerLazySingleton(() => GetAllSpells(repository: sl()));

  // Providers
  sl.registerLazySingleton(() => SettingsProvider());
}
