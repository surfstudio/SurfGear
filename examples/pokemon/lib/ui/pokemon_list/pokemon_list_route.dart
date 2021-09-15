import 'package:flutter/material.dart';
import 'package:pokemon/ui/pokemon_list/pokemon_list_screen.dart';
import 'package:provider/provider.dart';

import 'pokemon_list_wm.dart';

class PokemonListRoute extends MaterialPageRoute {
  PokemonListRoute()
      : super(
            builder: (ctx) => const PokemonListScreen(
                  widgetModelBuilder: _createPokemonListWM,
                ));
}

PokemonListWM _createPokemonListWM(BuildContext ctx) {
  return ctx.read<PokemonListWM>();
}