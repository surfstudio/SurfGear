import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';

import 'pokemon_show_wm.dart';

class PokemonShowScreen extends CoreMwwmWidget<PokemonShowWM> {
  const PokemonShowScreen({required WidgetModelBuilder<PokemonShowWM> widgetModelBuilder, Key? key,}) : super(key: key, widgetModelBuilder: widgetModelBuilder);

  @override
  WidgetState<CoreMwwmWidget<PokemonShowWM>, PokemonShowWM> createWidgetState() => _PokemonShowScreenState();
}

class _PokemonShowScreenState extends WidgetState<PokemonShowScreen, PokemonShowWM> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pokedex"),
      ),
      body: Container(),
    );
  }

}