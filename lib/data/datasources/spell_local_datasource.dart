import 'package:hive/hive.dart';
import '../models/spell_model.dart';

abstract class SpellLocalDataSource {
  Future<List<SpellModel>> getSpells();
  Future<void> saveSpells(List<SpellModel> spells);
}

class SpellLocalDataSourceImpl implements SpellLocalDataSource {
  static const String _boxName = 'spells';

  @override
  Future<List<SpellModel>> getSpells() async {
    try {
      final box = await Hive.openBox<SpellModel>(_boxName);
      return box.values.toList();
    } catch (e) {
      throw Exception('Error reading spells from local storage: $e');
    }
  }

  @override
  Future<void> saveSpells(List<SpellModel> spells) async {
    try {
      final box = await Hive.openBox<SpellModel>(_boxName);
      await box.clear();
      for (int i = 0; i < spells.length; i++) {
        await box.put(i, spells[i]);
      }
    } catch (e) {
      throw Exception('Error saving spells to local storage: $e');
    }
  }
}
