class Spell {
  final String id;
  final String name;
  final String? description;

  Spell({
    required this.id,
    required this.name,
    this.description,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Spell && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Spell(id: $id, name: $name, description: $description)';
  }
}
