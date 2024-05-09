import 'package:miscelaneos/infrastructure/infrastructure.dart';
import 'package:workmanager/workmanager.dart';

const fetchBackgroundTaskKey =
    'com.sergiobarreras.miscelaneos.fetch-background-pokemon';
const fetchPeriodicBackgroundTaskKey =
    'com.sergiobarreras.miscelaneos.fetch-background-pokemon';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    switch (taskName) {
      case fetchBackgroundTaskKey:
        await loadNextPokemon();
        break;
      case fetchPeriodicBackgroundTaskKey:
        print('fetchPeriodicBackgroundTaskKey');
        break;
    }
    return true;

    // print("Native: called background task $taskName");
  });
}

Future loadNextPokemon() async {
  final localDbRepository = LocalDbRepositoryImpl();
  final pokemonRepository = PokemonsRepositryImpl();

  final lastPokemonId = await localDbRepository.pokemonCount() + 1;

  try {
    final (pokemon, message) =
        await pokemonRepository.getPokemon('$lastPokemonId');
    if (pokemon == null) throw message;

    await localDbRepository.insertPokemon(pokemon);
    print('Pokemon inserted: ${pokemon.name}');
  } catch (e) {
    print(e);
  }
}
