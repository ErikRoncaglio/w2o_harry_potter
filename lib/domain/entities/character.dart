class Character {
  final String id;
  final String name;
  final String? house;
  final String? image;
  final String? actor;

  Character({
    required this.id,
    required this.name,
    this.house,
    this.image,
    this.actor,
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
