import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:password/password.dart';

class AuthService {
  static AuthService instance = AuthService();
  bool _isAuthenticated = true;
  final storage = new FlutterSecureStorage();

  Future<bool> login(String password) async {
    var storedPassword = await storage.read(key: 'password');
    if (password.length == 0 && storedPassword == null) {
      return _isAuthenticated = true;
    } else if (password.length == 0 || storedPassword == null) {
      return _isAuthenticated = false;
    } else {
      return _isAuthenticated = Password.verify(password, storedPassword);
    }
  }

  bool get isAuthenticated {
    return _isAuthenticated;
  }

  Future<void> savePassword(String password) async {
    var pass = Password.hash(password, new PBKDF2());
    await storage.write(key: 'password', value: pass);
  }
}