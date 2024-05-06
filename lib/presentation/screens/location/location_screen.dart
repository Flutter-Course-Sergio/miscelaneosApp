import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/presentation/providers/providers.dart';

class LocationScreen extends ConsumerWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userLocationAsync = ref.watch(userLocationProvider);
    final watchLocationAsync = ref.watch(watchLocationProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Ubicación')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Ubicación actual'),
            userLocationAsync.when(
              data: (location) => Text(location.toString()),
              loading: () => const CircularProgressIndicator(),
              error: (error, stackTrace) => Text(error.toString()),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text('Seguimiento de ubicación'),
            watchLocationAsync.when(
              data: (location) => Text(location.toString()),
              loading: () => const CircularProgressIndicator(),
              error: (error, stackTrace) => Text(error.toString()),
            ),
          ],
        ),
      ),
    );
  }
}
