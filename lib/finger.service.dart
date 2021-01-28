import 'package:local_auth/local_auth.dart';

class FingerService {
  static FingerService instance = FingerService();
  final _localAuth = LocalAuthentication();
  bool canCheckBiometrics;

  FingerService() {
    _localAuth.canCheckBiometrics.then((value) => canCheckBiometrics = value);
  }

  Future<bool> authenticate() async {
    try {
      return await _localAuth.authenticateWithBiometrics(
          localizedReason: "Use your finger print to log in.");
    } catch (e) {
      print(e);
      return false;
    }
  }
}
