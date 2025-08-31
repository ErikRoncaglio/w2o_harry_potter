import 'package:hive/hive.dart';
import '../models/character_model.dart';

abstract class CharacterLocalDataSource {
  Future<List<CharacterModel>> getCharacters();
  Future<void> saveCharacters(List<CharacterModel> characters);
}

class CharacterLocalDataSourceImpl implements CharacterLocalDataSource {
  static const String _boxName = 'characters';

  @override
  Future<List<CharacterModel>> getCharacters() async {
    final box = await Hive.openBox<CharacterModel>(_boxName);
    return box.values.toList();
  }

  @override
  Future<void> saveCharacters(List<CharacterModel> characters) async {
    final box = await Hive.openBox<CharacterModel>(_boxName);
    await box.clear();

    for (int i = 0; i < characters.length; i++) {
      await box.put(i, characters[i]);
    }
  }
}
