import 'package:flutter/material.dart';
import '../../domain/entities/spell.dart';
import '../../domain/usecases/get_all_spells.dart';

class SpellProvider extends ChangeNotifier {
  final GetAllSpells _getAllSpells;

  SpellProvider({required GetAllSpells getAllSpells})
      : _getAllSpells = getAllSpells;

  bool _isLoading = false;
  List<Spell> _spells = <Spell>[];
  String? _errorMessage;

  bool get isLoading => _isLoading;
  List<Spell> get spells => _spells;
  String? get errorMessage => _errorMessage;

  Future<void> fetchSpells() async {
    _isLoading = true;
    notifyListeners();

    try {
      _spells = await _getAllSpells.call();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = 'Erro ao carregar magias: ${e.toString()}';
      _spells = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
