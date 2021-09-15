import 'package:flutter/material.dart';

import 'pokemon_list/pokemon_list_route.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.orange
      ),
      onGenerateRoute: (_) => PokemonListRoute(),
    );
  }
}