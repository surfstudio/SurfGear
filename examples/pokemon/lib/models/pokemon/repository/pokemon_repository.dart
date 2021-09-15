import 'package:flutter/material.dart';
import 'package:pokemon/models/pokemon/repository/pokemon_api_client.dart';

import '../pokemon.dart';

/// Repository for collecting data with http-client
class PokemonRepository {
  final PokemonApiClient? pokemonApiClient;

  PokemonRepository({@required this.pokemonApiClient})
      : assert(pokemonApiClient != null);

  Future<Pokemon> getPokemon() async {
    return pokemonApiClient!.fetchPokemon();
  }
}
