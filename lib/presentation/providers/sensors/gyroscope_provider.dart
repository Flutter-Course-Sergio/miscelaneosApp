import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sensors_plus/sensors_plus.dart';

final gyroscopeProvider =
    StreamProvider.autoDispose<GyroscopeXYZ>((ref) async* {
  await for (final event in gyroscopeEvents) {
    final x = double.parse(event.x.toStringAsFixed(2));
    final y = double.parse(event.y.toStringAsFixed(2));
    final z = double.parse(event.z.toStringAsFixed(2));

    yield GyroscopeXYZ(x: x, y: y, z: z);
  }
});

class GyroscopeXYZ {
  final double x;
  final double y;
  final double z;

  GyroscopeXYZ({required this.x, required this.y, required this.z});

  @override
  String toString() {
    return '''
    X:$x,
    Y:$y,
    Z:$z
    ''';
  }
}
