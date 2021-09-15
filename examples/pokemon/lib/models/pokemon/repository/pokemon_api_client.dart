import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokemon/models/pokemon/pokemon.dart';

/// HTTP-client for fetching data from [_baseUrl]
class PokemonApiClient {
  static const String _baseUrl = 'https://app.pokemon-api.xyz/pokemon/random';
  final http.Client? httpClient;

  PokemonApiClient({
    @required this.httpClient,
  }) : assert(httpClient != null);

  /// Retreive Random Pokemon 
  Future<Pokemon> fetchPokemon() async {
    final listUrl = Uri.parse(_baseUrl);
    final response = await httpClient?.get(listUrl);

    if (response?.statusCode != 200) {
      throw Exception('Error getting pokemon list');
    }

    final data = jsonDecode(response!.body);
    return Pokemon.fromJson(data);
  }
}