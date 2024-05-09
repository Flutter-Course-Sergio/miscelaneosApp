import 'package:flutter/material.dart';

import '../../../domain/domain.dart';

class DbPokemonScreen extends StatelessWidget {
  const DbPokemonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Background Process'),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.add_alarm_rounded))
        ],
      ),
      body: CustomScrollView(slivers: [_PokemonGrid(pokemons: [])]),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text('Activar fetch periodico'),
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
