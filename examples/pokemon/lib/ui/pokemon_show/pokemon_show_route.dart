import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:pokemon/models/pokemon/interactors/pokemon_interactor.dart';
import 'package:provider/provider.dart';

import 'pokemon_show_screen.dart';
import 'pokemon_show_wm.dart';

class PokemonShowRoute extends MaterialPageRoute {
  PokemonShowRoute()
      : super(
            builder: (ctx) => const PokemonShowScreen(
                  widgetModelBuilder: _createPokemonShowWM,
                ));
}

PokemonShowWM _createPokemonShowWM(BuildContext ctx) =>
    PokemonShowWM(const WidgetModelDependencies(), ctx.read<PokemonInteractor>());
