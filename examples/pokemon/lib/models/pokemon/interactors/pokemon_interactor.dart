import 'package:pokemon/models/pokemon/pokemon.dart';
import 'package:pokemon/models/pokemon/repository/pokemon_repository.dart';

/// Basic interactor
class PokemonInteractor {
  final PokemonRepository _pokemonRepository;

  PokemonInteractor(this._pokemonRepository);

  /// Retrieve random Pokemon
  Future<Pokemon> getRandomPokemon() async {
    final pokemon = await _pokemonRepository.getPokemon();
    return pokemon;
  }
}