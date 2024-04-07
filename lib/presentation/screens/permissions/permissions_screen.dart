import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/presentation/providers/providers.dart';

class PermissionsScreen extends StatelessWidget {
  const PermissionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Permisos'),
        ),
        body: const _PermissionsView());
  }
}

class _PermissionsView extends ConsumerWidget {
  const _PermissionsView();

  @override
  Widget build(BuildContext context, ref) {
    final permissions = ref.watch(permissionsProvider);

    return ListView(
      children: [
        // Cámara
        CheckboxListTile(
            value: permissions.cameraGranted,
            title: const Text('Cámara'),
            subtitle: Text("${permissions.camera}"),
            onChanged: (value) {
              ref.read(permissionsProvider.notifier).requestCameraAccess();
            }),
        //Galería
        CheckboxListTile(
            value: permissions.photoLibraryGranted,
            title: const Text('Galería de fotos'),
            subtitle: Text("${permissions.photoLibrary}"),
            onChanged: (value) {
              ref
                  .read(permissionsProvider.notifier)
                  .requestPhotoLibraryAccess();
            }),
        //Ubicación
        CheckboxListTile(
            value: permissions.locationGranted,
            title: const Text('Ubicación'),
            subtitle: Text("${permissions.location}"),
            onChanged: (value) {
              ref.read(permissionsProvider.notifier).requestLocationAccess();
            }),
        //Sensores
        CheckboxListTile(
            value: permissions.sensorGranted,
            title: const Text('Sensores'),
            subtitle: Text("${permissions.sensor}"),
            onChanged: (value) {
              ref.read(permissionsProvider.notifier).requestSensorsAccess();
            }),
      ],
    );
  }
}
