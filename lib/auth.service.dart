import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'file.service.dart';
import 'package:dbcrypt/dbcrypt.dart';

class AuthService {
  static AuthService instance = AuthService();
  bool _isAuthenticated = true;
  final storage = new FlutterSecureStorage();

  Future<bool> login(String password) async {
    final String storedPassword = await storage.read(key: 'password');
    if (password.length == 0 && storedPassword == null) {
      return _isAuthenticated = true;
    } else if (password.length == 0 || storedPassword == null) {
      return _isAuthenticated = false;
    } else {
      return _isAuthenticated = new DBCrypt().checkpw(password, storedPassword);
    }
  }

  bool get isAuthenticated {
    return _isAuthenticated;
  }

  Future<void> savePassword(String password) async {
    final String pass = new DBCrypt().hashpw(password, new DBCrypt().gensalt());
    await storage.write(key: 'password', value: pass);
    await FileService.instance.createFileKey(password);
  }
}