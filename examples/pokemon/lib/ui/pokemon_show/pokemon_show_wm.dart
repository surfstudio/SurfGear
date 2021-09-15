import 'package:mwwm/mwwm.dart';
import 'package:pokemon/models/pokemon/interactors/pokemon_interactor.dart';
import 'package:pokemon/models/pokemon/pokemon.dart';
import 'package:relation/relation.dart';
import 'package:surf_logger/surf_logger.dart';

/// WidgetModel for PokemonShowScreen
class PokemonShowWM extends WidgetModel {
  // Using relation for updating state
  final pokemon = StreamedState<Pokemon?>(null);
  final PokemonInteractor _pokemonInteractor;

  PokemonShowWM(
    WidgetModelDependencies baseDependencies,
    this._pokemonInteractor,
  ) : super(baseDependencies);

  /// Initial loading
  @override
  void onLoad() {
    super.onLoad();
    Logger.d("PokemonShowWidgetModel has been loaded");
    getRandomPokemon();
    Logger.d("Web request for Pokemon has been completed");
  }

  /// Fetch random Pokemon
  Future getRandomPokemon() async {
    await pokemon.accept(null);
    final data = await _pokemonInteractor.getRandomPokemon();
    await pokemon.accept(data);
  }
}
