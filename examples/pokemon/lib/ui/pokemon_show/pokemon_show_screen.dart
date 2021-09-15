import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:pokemon/models/pokemon/pokemon.dart';
import 'package:pokemon/ui/widgets/pokemon_title.dart';
import 'package:pokemon/ui/widgets/quick_info_panel.dart';
import 'package:pokemon/ui/widgets/type_drawer.dart';
import 'package:relation/relation.dart';

import 'pokemon_show_wm.dart';

/// View screen for single Pokemon instance
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
            return ListView(
              padding: const EdgeInsets.only(
                  left: 16.0, right: 16.0, top: 12.0, bottom: 8.0),
              children: [
                PokemonTitle(pokemon.name as String),
                QuickInfoPanel(
                  height: pokemon.height,
                  species: pokemon.species,
                  imageUrl: pokemon.sprite,
                ),
                const SizedBox(height: 16.0),
                TypeDrawer(pokemon.types as List<dynamic>),
                const SizedBox(height: 16.0),
                Expanded(
                    child: Text(pokemon.description as String,
                        style: const TextStyle(fontSize: 20.0))),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            wm.getRandomPokemon(); // Fetch new random Pokemon
          },
          child: const Icon(Icons.update)),
    );
  }
}
