import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:pokemon/models/pokemon/pokemon.dart';
import 'package:relation/relation.dart';

import 'pokemon_show_wm.dart';

class PokemonShowScreen extends CoreMwwmWidget<PokemonShowWM> {
  const PokemonShowScreen({
    required WidgetModelBuilder<PokemonShowWM> widgetModelBuilder,
    Key? key,
  }) : super(key: key, widgetModelBuilder: widgetModelBuilder);

  @override
  WidgetState<CoreMwwmWidget<PokemonShowWM>, PokemonShowWM>
      createWidgetState() => _PokemonShowScreenState();
}

class _PokemonShowScreenState
    extends WidgetState<PokemonShowScreen, PokemonShowWM> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pokedex"),
      ),
      body: StreamedStateBuilder<Pokemon?>(
        streamedState: wm.pokemon,
        builder: (ctx, pokemon) {
          if (pokemon != null) {
            return Column(
              children: [
                Text(pokemon.name as String),
              ],
            ); 
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            wm.getRandomPokemon();
          },
          child: const Icon(Icons.update)),
    );
  }
}
