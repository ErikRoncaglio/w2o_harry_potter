import '../entities/spell.dart';

abstract class SpellRepository {
  Future<List<Spell>> getSpells();
}
