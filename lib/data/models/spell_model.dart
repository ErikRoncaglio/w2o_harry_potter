import 'package:hive/hive.dart';
import '../../domain/entities/spell.dart';

part 'spell_model.g.dart';

@HiveType(typeId: 2)
class SpellModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String? description;

  SpellModel({
    required this.id,
    required this.name,
    this.description,
  });

  factory SpellModel.fromJson(Map<String, dynamic> json) {
    return SpellModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] as String?,
    );
  }

  Spell toEntity() {
    return Spell(
      id: id,
      name: name,
      description: description,
    );
  }
}
