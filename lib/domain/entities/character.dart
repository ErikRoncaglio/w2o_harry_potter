class Character {
  final String id;
  final String name;
  final List<String> alternateNames;
  final String? species;
  final String? gender;
  final String? house;
  final String? dateOfBirth;
  final int? yearOfBirth;
  final bool wizard;
  final String? ancestry;
  final String? eyeColour;
  final String? hairColour;
  final String? wandWood;
  final String? wandCore;
  final double? wandLength;
  final String? patronus;
  final bool hogwartsStudent;
  final bool hogwartsStaff;
  final String? actor;
  final List<String> alternateActors;
  final bool alive;
  final String? image;

  Character({
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
    this.wandWood,
    this.wandCore,
    this.wandLength,
    this.patronus,
    required this.hogwartsStudent,
    required this.hogwartsStaff,
    this.actor,
    required this.alternateActors,
    required this.alive,
    this.image,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Character && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Character(id: $id, name: $name, house: $house, actor: $actor)';
  }
}
