import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  static AuthService instance = AuthService();
  bool _isAuthenticated = true;
  final storage = new FlutterSecureStorage();

  Future<bool> login(String password) async {
    var storedPassword = await storage.read(key: 'password');
    return password == storedPassword;
  }

  bool get isAuthenticated {
    return _isAuthenticated;
  }

  Future<void> savePassword(String password) async {
    await storage.write(key: 'password', value: password);
    password = password;
  }
}