import 'package:hive/hive.dart';
import '../../domain/entities/character.dart';

part 'character_model.g.dart';

@HiveType(typeId: 0)
class WandModel {
  @HiveField(0)
  final String? wood;

  @HiveField(1)
  final String? core;

  @HiveField(2)
  final double? length;

  WandModel({this.wood, this.core, this.length});

  factory WandModel.fromJson(Map<String, dynamic> json) {
    return WandModel(
      wood: json['wood'] as String?,
      core: json['core'] as String?,
      length: json['length']?.toDouble(),
    );
  }
}

@HiveType(typeId: 1)
class CharacterModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final List<String> alternateNames;

  @HiveField(3)
  final String? species;

  @HiveField(4)
  final String? gender;

  @HiveField(5)
  final String? house;

  @HiveField(6)
  final String? dateOfBirth;

  @HiveField(7)
  final int? yearOfBirth;

  @HiveField(8)
  final bool wizard;

  @HiveField(9)
  final String? ancestry;

  @HiveField(10)
  final String? eyeColour;

  @HiveField(11)
  final String? hairColour;

  @HiveField(12)
  final WandModel? wand;

  @HiveField(13)
  final String? patronus;

  @HiveField(14)
  final bool hogwartsStudent;

  @HiveField(15)
  final bool hogwartsStaff;

  @HiveField(16)
  final String? actor;

  @HiveField(17)
  final List<String> alternateActors;

  @HiveField(18)
  final bool alive;

  @HiveField(19)
  final String? image;

  CharacterModel({
    required this.id,
    required this.name,
    required this.alternateNames,
    this.species,
    this.gender,
    this.house,
    this.dateOfBirth,
    this.yearOfBirth,
    required this.wizard,
    this.ancestry,
    this.eyeColour,
    this.hairColour,
    this.wand,
    this.patronus,
    required this.hogwartsStudent,
    required this.hogwartsStaff,
    this.actor,
    required this.alternateActors,
    required this.alive,
    this.image,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      alternateNames: List<String>.from(json['alternate_names'] ?? []),
      species: json['species'] as String?,
      gender: json['gender'] as String?,
      house: json['house'] as String?,
      dateOfBirth: json['dateOfBirth'] as String?,
      yearOfBirth: json['yearOfBirth'] as int?,
      wizard: json['wizard'] ?? false,
      ancestry: json['ancestry'] as String?,
      eyeColour: json['eyeColour'] as String?,
      hairColour: json['hairColour'] as String?,
      wand: json['wand'] != null ? WandModel.fromJson(json['wand']) : null,
      patronus: json['patronus'] as String?,
      hogwartsStudent: json['hogwartsStudent'] ?? false,
      hogwartsStaff: json['hogwartsStaff'] ?? false,
      actor: json['actor'] as String?,
      alternateActors: List<String>.from(json['alternate_actors'] ?? []),
      alive: json['alive'] ?? false,
      image: json['image'] as String?,
    );
  }

  Character toEntity() {
    return Character(
      id: id,
      name: name,
      alternateNames: alternateNames,
      species: species,
      gender: gender,
      house: house,
      dateOfBirth: dateOfBirth,
      yearOfBirth: yearOfBirth,
      wizard: wizard,
      ancestry: ancestry,
      eyeColour: eyeColour,
      hairColour: hairColour,
      wandWood: wand?.wood,
      wandCore: wand?.core,
      wandLength: wand?.length,
      patronus: patronus,
      hogwartsStudent: hogwartsStudent,
      hogwartsStaff: hogwartsStaff,
      actor: actor,
      alternateActors: alternateActors,
      alive: alive,
      image: image,
    );
  }
}
