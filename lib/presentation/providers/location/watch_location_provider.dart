import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

final watchLocationProvider =
    StreamProvider.autoDispose<(double, double)>((ref) async* {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();

  if (!serviceEnabled) {
    throw 'Location service is not enabled';
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      throw 'Location permission denied';
    }
  }

  if (permission == LocationPermission.deniedForever) {
    throw 'Location permission permanently denied';
  }

  await for (final pos in Geolocator.getPositionStream()) {
    yield (pos.latitude, pos.longitude);
  }
});
