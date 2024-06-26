import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workmanager/workmanager.dart';

import '../../../config/config.dart';
import '../../../domain/domain.dart';
import '../../providers/providers.dart';

class DbPokemonScreen extends ConsumerWidget {
  const DbPokemonScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemonsAsync = ref.watch(pokemonDbProvider);
    final isBackgroundFetchActive = ref.watch(backgroundPokemonFetchProvider);

    if (pokemonsAsync.isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final List<Pokemon> pokemons = pokemonsAsync.value ?? [];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Background Process'),
        actions: [
          IconButton(
              onPressed: () {
                Workmanager().registerOneOffTask(
                    fetchBackgroundTaskKey, fetchBackgroundTaskKey,
                    initialDelay: const Duration(seconds: 3),
                    inputData: {'howMany': 30});
              },
              icon: const Icon(Icons.add_alarm_rounded))
        ],
      ),
      body: CustomScrollView(slivers: [_PokemonGrid(pokemons: pokemons)]),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ref.read(backgroundPokemonFetchProvider.notifier).toggleTask();
        },
        label: (isBackgroundFetchActive == true)
            ? const Text('Desactivar fetch periodico')
            : const Text('Activar fetch periodico'),
        icon: const Icon(Icons.av_timer),
      ),
    );
  }
}

class _PokemonGrid extends StatelessWidget {
  final List<Pokemon> pokemons;
  const _PokemonGrid({required this.pokemons});

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, crossAxisSpacing: 2, mainAxisSpacing: 2),
      itemCount: pokemons.length,
      itemBuilder: (context, index) {
        final pokemon = pokemons[index];

        return Column(
          children: [
            Image.network(
              pokemon.frontSprite,
              fit: BoxFit.contain,
            ),
            Text(pokemon.name)
          ],
        );
      },
    );
  }
}
