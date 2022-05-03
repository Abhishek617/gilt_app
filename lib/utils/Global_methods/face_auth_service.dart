import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class FaceAuthService {
  static final LocalAuthentication auth = LocalAuthentication();
  static _SupportState _supportState = _SupportState.unknown;
  static bool? _canCheckBiometrics;
  static List<BiometricType>? _availableBiometrics;
  static String _authorized = 'Not Authorized';
  static bool _isAuthenticating = false;

  static faceAuthInIt() {
    auth.isDeviceSupported().then((bool isSupported) => _supportState =
        isSupported ? _SupportState.supported : _SupportState.unsupported);
  }

  static Future<void> checkBiometrics() async {
    late bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      canCheckBiometrics = false;
      print(e);
    }

    _canCheckBiometrics = canCheckBiometrics;
  }

  static Future<void> getAvailableBiometrics() async {
    late List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      availableBiometrics = <BiometricType>[];
      print(e);
    }
    _availableBiometrics = availableBiometrics;
  }

  static Future<void> authenticate() async {
    print("authenticate called...");
    bool authenticated = false;
    try {
      _isAuthenticating = true;
      _authorized = 'Authenticating';
      authenticated = await auth.authenticate(
        localizedReason: 'Let OS determine authentication method',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );
      _isAuthenticating = false;
    } on PlatformException catch (e) {
      print(e);
      _isAuthenticating = false;
      _authorized = 'Error - ${e.message}';
      return;
    }
    _authorized = authenticated ? 'Authorized' : 'Not Authorized';
  }

  static Future<void> authenticateWithBiometrics() async {
    bool authenticated = false;
    try {
      _isAuthenticating = true;
      _authorized = 'Authenticating';
      authenticated = await auth.authenticate(
        localizedReason:
            'Scan your fingerprint (or face or whatever) to authenticate',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      _isAuthenticating = false;
      _authorized = 'Authenticating';
    } on PlatformException catch (e) {
      print(e);
      _isAuthenticating = false;
      _authorized = 'Error - ${e.message}';
      return;
    }

    final String message = authenticated ? 'Authorized' : 'Not Authorized';
    _authorized = message;
  }

  static Future<void> cancelAuthentication() async {
    await auth.stopAuthentication();
    _isAuthenticating = false;
  }
}

enum _SupportState {
  unknown,
  supported,
  unsupported,
}
