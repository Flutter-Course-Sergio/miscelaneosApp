import 'package:miscelaneos/config/config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final canCheckBiometricsProvider = FutureProvider<bool>((ref) async {
  return await LocalAuthPlugin.canCheckBiometrics();
});

final localAuhtProvider =
    StateNotifierProvider<LocalAuthNotifier, LocalAuthState>((ref) {
  return LocalAuthNotifier();
});

enum LocalAuthStatus { authenticated, notAuthenticated, authenticating }

class LocalAuthState {
  final bool didAtenticate;
  final LocalAuthStatus status;
  final String message;

  LocalAuthState(
      {this.didAtenticate = false,
      this.status = LocalAuthStatus.notAuthenticated,
      this.message = ''});

  LocalAuthState copyWith({
    bool? didAtenticate,
    LocalAuthStatus? status,
    String? message,
  }) =>
      LocalAuthState(
        didAtenticate: didAtenticate ?? this.didAtenticate,
        status: status ?? this.status,
        message: message ?? this.message,
      );

  @override
  String toString() {
    return '''
didAtenticate: $didAtenticate
status: $status
message: $message
    ''';
  }
}

class LocalAuthNotifier extends StateNotifier<LocalAuthState> {
  LocalAuthNotifier() : super(LocalAuthState());

  Future<(bool, String)> authenticateUser() async {
    final (didAutenticate, message) = await LocalAuthPlugin.authenticate();
    state = state.copyWith(
        didAtenticate: didAutenticate,
        message: message,
        status: didAutenticate
            ? LocalAuthStatus.authenticated
            : LocalAuthStatus.notAuthenticated);

    return (didAutenticate, message);
  }
}
