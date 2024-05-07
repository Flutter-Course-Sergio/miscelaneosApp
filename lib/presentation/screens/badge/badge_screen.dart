import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/providers.dart';

class BadgeScreen extends ConsumerWidget {
  const BadgeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final badgeCounter = ref.watch(badgeCounterProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('App Badge'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Badge(
              alignment: Alignment.lerp(
                  Alignment.topRight, Alignment.bottomRight, 0.2),
              label: Text("$badgeCounter"),
              child:
                  Text('$badgeCounter', style: const TextStyle(fontSize: 150)),
            ),
            FilledButton.tonal(
                onPressed: () {
                  ref.invalidate(badgeCounterProvider);
                },
                child: const Text('Clear badge'))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            ref.read(badgeCounterProvider.notifier).state++;
          },
          child: const Icon(Icons.plus_one)),
    );
  }
}
