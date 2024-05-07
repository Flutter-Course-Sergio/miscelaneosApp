import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:miscelaneos/presentation/providers/providers.dart';

class ControlledMapScreen extends ConsumerWidget {
  const ControlledMapScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final watchUserLocation = ref.watch(watchLocationProvider);

    return Scaffold(
        body: watchUserLocation.when(
      data: (location) => MapAndControls(
        latitude: location.$1,
        longitude: location.$2,
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, stackTrace) => Center(
        child: Text('Error: $error'),
      ),
    ));
  }
}

class MapAndControls extends ConsumerWidget {
  final double latitude;
  final double longitude;

  const MapAndControls(
      {super.key, required this.latitude, required this.longitude});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapControllerState = ref.watch(mapControllerProvider);

    return Stack(
      children: [
        _MapView(initialLat: latitude, initialLng: longitude),
        Positioned(
          top: 40,
          left: 20,
          child: IconButton.filledTonal(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.arrow_back)),
        ),
        Positioned(
          bottom: 40,
          left: 20,
          child: IconButton.filledTonal(
              onPressed: () {
                ref.read(mapControllerProvider.notifier).findUser();
              },
              icon: const Icon(Icons.location_searching)),
        ),
        Positioned(
          bottom: 90,
          left: 20,
          child: IconButton.filledTonal(
              onPressed: () {
                ref.read(mapControllerProvider.notifier).toggleFollowUser();
              },
              icon: Icon(mapControllerState.followUser
                  ? Icons.directions_run_rounded
                  : Icons.accessibility_new_rounded)),
        ),
        Positioned(
          bottom: 140,
          left: 20,
          child: IconButton.filledTonal(
              onPressed: () {
                ref
                    .read(mapControllerProvider.notifier)
                    .addMarkerCurrentPosition();
              },
              icon: const Icon(Icons.pin_drop)),
        )
      ],
    );
  }
}

class _MapView extends ConsumerStatefulWidget {
  final double initialLat;
  final double initialLng;

  const _MapView({required this.initialLat, required this.initialLng});

  @override
  __MapViewState createState() => __MapViewState();
}

class __MapViewState extends ConsumerState<_MapView> {
  @override
  Widget build(BuildContext context) {
    final mapController = ref.watch(mapControllerProvider);

    return GoogleMap(
      onLongPress: (arg) {
        ref
            .read(mapControllerProvider.notifier)
            .addMarker(arg.latitude, arg.longitude);
      },
      markers: mapController.markersSet,
      mapType: MapType.normal,
      initialCameraPosition: CameraPosition(
          target: LatLng(widget.initialLat, widget.initialLng), zoom: 15),
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      onMapCreated: (GoogleMapController controller) {
        ref.read(mapControllerProvider.notifier).setMapController(controller);
      },
    );
  }
}
