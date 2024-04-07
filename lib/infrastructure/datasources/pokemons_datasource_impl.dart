import 'package:dio/dio.dart';
import 'package:miscelaneos/domain/entities/pokemon.dart';

import '../../domain/datasources/pokemons_datasource.dart';

class PokemonsDatasourceImpl implements PokemonsDatasource {
  final Dio dio;

  PokemonsDatasourceImpl()
      : dio = Dio(BaseOptions(baseUrl: 'https://pokeapi.co/api/v2'));

  @override
  Future<(Pokemon?, String)> getPokemon(String id) async {
    try {
      final resp = await dio.get('/pokemon/$id');
    } catch (e) {
      return (null, 'No se pudo obtener el pokémon $e');
    }
  }
}
