/// Pokemon data model
class Pokemon {
  final String? name;
  final String? description;
  final String? sprite;
  final List<String>? types;
  final double? height;
  final double? weight;

  Pokemon({
    this.name,
    this.description,
    this.sprite,
    this.types,
    this.height,
    this.weight,
  });

  /// Create object from JSON
  factory Pokemon.fromJson(Map<String, dynamic> json) => Pokemon(
    name: json["name"]["English"],
    description: json["description"],
    sprite: json["sprite"],
    types: json["types"],
    height: json["profile"]["height"],
    weight: json["profile"]["wight"],
  );
}