import 'package:flutter/material.dart';
import 'package:pokemon/models/pokemon/interactors/pokemon_interactor.dart';
import 'package:pokemon/models/pokemon/repository/pokemon_api_client.dart';
import 'package:pokemon/models/pokemon/repository/pokemon_repository.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'pokemon_show/pokemon_show_route.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    // Collecting dependecies
    final client = http.Client();
    final pokemonApiClient = PokemonApiClient(httpClient: client);
    final pokemonRepository =
        PokemonRepository(pokemonApiClient: pokemonApiClient);
    final pokemonInteractor = PokemonInteractor(pokemonRepository);

    return Provider(
      create: (_) => pokemonInteractor,
      child: MaterialApp(
        theme: ThemeData(primarySwatch: Colors.orange),
        onGenerateRoute: (_) => PokemonShowRoute(),
      ),
    );
  }
}
