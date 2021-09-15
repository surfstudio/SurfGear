/// Pokemon data model
class Pokemon {
  final String? name;
  final int? baseExperience;
  final String? sprite;
  final List<Type>? types;

  Pokemon({
    this.name,
    this.baseExperience,
    this.sprite,
    this.types
  });

  /// Create object from JSON
  factory Pokemon.fromJson(Map<String, dynamic> json) => Pokemon(
    name: json["name"],
    baseExperience: json["baseExperience"],
    sprite: json["sprites"]["front_default"],
    types: json["types"]
  );
}