/// Pokemon data model
class Pokemon {
  final String? name;
  final String? description;
  final String? sprite;
  final List<dynamic>? types;
  final String? height;
  final String? species;

  Pokemon({
    this.name,
    this.description,
    this.sprite,
    this.types,
    this.height,
    this.species,
  });

  /// Create object from JSON
  factory Pokemon.fromJson(Map<String, dynamic> json) => Pokemon(
    name: json["name"]["english"],
    description: json["description"],
    sprite: json["thumbnail"],
    types: json["type"],
    height: json["profile"]["height"],
    species: json["species"],
  );
}