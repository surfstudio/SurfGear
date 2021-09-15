import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:pokemon/ui/pokemon_list/pokemon_list_wm.dart';

class PokemonListScreen extends CoreMwwmWidget<PokemonListWM> {
  const PokemonListScreen({required WidgetModelBuilder<PokemonListWM> widgetModelBuilder, Key? key,}) : super(key: key, widgetModelBuilder: widgetModelBuilder);

  @override
  WidgetState<CoreMwwmWidget<PokemonListWM>, PokemonListWM> createWidgetState() => _PokemonListScreenState();
}

class _PokemonListScreenState extends WidgetState<PokemonListScreen, PokemonListWM> {
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