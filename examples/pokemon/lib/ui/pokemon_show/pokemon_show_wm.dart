import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:pokemon/models/pokemon/interactors/pokemon_interactor.dart';
import 'package:pokemon/models/pokemon/pokemon.dart';
import 'package:relation/relation.dart';
import 'package:surf_logger/surf_logger.dart';

class PokemonShowWM extends WidgetModel {
  final pokemon = StreamedState<Pokemon?>(null);
  final PokemonInteractor _pokemonInteractor;

  PokemonShowWM(
    WidgetModelDependencies baseDependencies,
    this._pokemonInteractor,
  ) : super(baseDependencies);

  @override
  void onLoad() {
    super.onLoad();
    Logger.d("PokemonShowWidgetModel has been loaded");
  }

  Future getRandomPokemon() async {
    final data = await _pokemonInteractor.getRandomPokemon();
    await pokemon.accept(data);
  }
}
