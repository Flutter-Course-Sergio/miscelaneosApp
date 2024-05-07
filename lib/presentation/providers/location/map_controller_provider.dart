import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapState {
  final bool isReady;
  final bool followUser;
  final List<Marker> markers;
  final GoogleMapController? controller;

  MapState(
      {this.isReady = false,
      this.followUser = false,
      this.markers = const [],
      this.controller});

  Set<Marker> get markersSet {
    return Set.from(markers);
  }

  MapState copyWith({
    bool? isReady,
    bool? followUser,
    List<Marker>? markers,
    GoogleMapController? controller,
  }) {
    return MapState(
      isReady: isReady ?? this.isReady,
      followUser: followUser ?? this.followUser,
      markers: markers ?? this.markers,
      controller: controller ?? this.controller,
    );
  }
}

class MapNotifier extends StateNotifier<MapState> {
  StreamSubscription? userLocation$;
  (double, double)? lastKnowLocation;

  MapNotifier() : super(MapState()) {
    trackUser().listen((event) {
      lastKnowLocation = (event.$1, event.$2);
    });
  }

  Stream<(double, double)> trackUser() async* {
    await for (final pos in Geolocator.getPositionStream()) {
      yield (pos.latitude, pos.longitude);
    }
  }

  void setMapController(GoogleMapController controller) {
    state = state.copyWith(controller: controller, isReady: true);
  }

  goToLocation(double latitude, double longitude) {
    final newPosition =
        CameraPosition(target: LatLng(latitude, longitude), zoom: 15);

    state.controller
        ?.animateCamera(CameraUpdate.newCameraPosition(newPosition));
  }

  toggleFollowUser() {
    state = state.copyWith(followUser: !state.followUser);

    if (state.followUser) {
      findUser();
      userLocation$ = trackUser().listen((event) {
        goToLocation(event.$1, event.$2);
      });
    } else {
      userLocation$?.cancel();
    }
  }

  findUser() {
    if (lastKnowLocation == null) return;
    final (latitude, longitude) = lastKnowLocation!;
    goToLocation(latitude, longitude);
  }

  void addMarkerCurrentPosition() {
    if (lastKnowLocation == null) return;
    final (latitude, longitude) = lastKnowLocation!;
    addMarker(latitude, longitude);
  }

  void addMarker(double lat, double lon) {
    final newMarker = Marker(
        markerId: MarkerId('${state.markers.length}'),
        position: LatLng(lat, lon));

    state = state.copyWith(markers: [...state.markers, newMarker]);
  }
}

final mapControllerProvider =
    StateNotifierProvider.autoDispose<MapNotifier, MapState>((ref) {
  return MapNotifier();
});
