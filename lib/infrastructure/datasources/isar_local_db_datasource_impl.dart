import 'package:isar/isar.dart';
import 'package:miscelaneos/domain/domain.dart';
import 'package:path_provider/path_provider.dart';

class IsarLocalDbDatasource extends LocalDbDatasource {
  late Future<Isar> db;

  IsarLocalDbDatasource() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    final dir = await getApplicationDocumentsDirectory();

    if (Isar.instanceNames.isEmpty) {
      return await Isar.open([PokemonSchema], directory: dir.path);
    }

    return Future.value(Isar.getInstance());
  }

  @override
  Future<void> insertPokemon(Pokemon pokemon) {
    // TODO: implement insertPokemon
    throw UnimplementedError();
  }

  @override
  Future<List<Pokemon>> loadPokemons() {
    // TODO: implement loadPokemons
    throw UnimplementedError();
  }

  @override
  Future<int> pokemonCount() {
    // TODO: implement pokemonCount
    throw UnimplementedError();
  }
}
