import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;

class LocalAuthPlugin {
  static final LocalAuthentication auth = LocalAuthentication();

  static availableBiometrics() async {
    final List<BiometricType> availableBiometrics =
        await auth.getAvailableBiometrics();

    if (availableBiometrics.isNotEmpty) {}

    if (availableBiometrics.contains(BiometricType.strong) ||
        availableBiometrics.contains(BiometricType.face)) {}
  }

  static Future<bool> canCheckBiometrics() async {
    return await auth.canCheckBiometrics;
  }

  static Future<(bool, String)> authenticate() async {
    try {
      final bool didAuthenticate = await auth.authenticate(
          localizedReason: 'Por favor verifica tu identidad para continuar',
          options: const AuthenticationOptions());

      availableBiometrics();

      return (
        didAuthenticate,
        didAuthenticate ? 'Hecho' : 'Cancelado por usuario',
      );
    } on PlatformException catch (e) {
      return handleError(e);
    }
  }

  static (bool, String) handleError(PlatformException ex) {
    String message = '';

    switch (ex.code) {
      case auth_error.notEnrolled:
        message = 'No hay biométricos enrolados';
        break;
      case auth_error.lockedOut:
        message = 'Muchos intentos fallidos';
        break;
      case auth_error.notAvailable:
        message = 'No hay biométricos disponible';
        break;
      case auth_error.passcodeNotSet:
        message = 'No hay pin configurado';
        break;
      case auth_error.permanentlyLockedOut:
        message = 'Se requiere desbloquear el teléfono de nuevo';
        break;
    }

    return (false, message);
  }
}
