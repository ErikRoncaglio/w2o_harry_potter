import '../entities/spell.dart';
import '../repositories/spell_repository.dart';

class GetAllSpells {
  final SpellRepository repository;

  GetAllSpells({required this.repository});

  Future<List<Spell>> call() async {
    return await repository.getSpells();
  }
}
