import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/presentation/providers/providers.dart';

class AccelerometerScreen extends ConsumerWidget {
  const AccelerometerScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final accelerometerG$ = ref.watch(accelerometerGravityProvider);
    final accelerometerU$ = ref.watch(accelerometerUserProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Acelerómetro'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Acelerómetro: Gravedad', style: TextStyle(fontSize: 30)),
          Center(
              child: accelerometerG$.when(
                  data: (value) => Text(
                        value.toString(),
                        style: const TextStyle(fontSize: 25),
                      ),
                  error: (error, stackTrace) => Text('error: $error'),
                  loading: () => const CircularProgressIndicator())),
          const SizedBox(height: 30),
          const Text('Acelerómetro: Usuario', style: TextStyle(fontSize: 30)),
          Center(
              child: accelerometerU$.when(
                  data: (value) => Text(
                        value.toString(),
                        style: const TextStyle(fontSize: 25),
                      ),
                  error: (error, stackTrace) => Text('error: $error'),
                  loading: () => const CircularProgressIndicator())),
        ],
      ),
    );
  }
}
