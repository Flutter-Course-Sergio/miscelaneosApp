import 'package:miscelaneos/domain/domain.dart';

class PokemonsRepositryImpl implements PokemonsRepository {
  final PokemonsDatasource datasource;

  PokemonsRepositryImpl(this.datasource);

  @override
  Future<(Pokemon?, String)> getPokemon(String id) async {
    return datasource.getPokemon(id);
  }
}
