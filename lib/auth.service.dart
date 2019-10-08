import 'package:shared_preferences/shared_preferences.dart';

class UserModel {
  String username;
  String password;
  UserModel({this.username, this.password});
}

class AuthService {
  static AuthService instance = AuthService();
  UserModel user = UserModel(username: "test");
  bool _isAuthenticated = true;

  AuthService() {
    SharedPreferences.getInstance().then((instance) {
      print('happend');
      var password = instance.getString('password');
      user.password = password ?? 'test';
    });
  }

  bool login(String username, String password) {
    return username == user.username && password == user.password;
  }

  bool get isAuthenticated {
    return _isAuthenticated;
  }

  Future<void> savePassword(String password) async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    // don't try this at home kids
    await instance.setString('password', password);
    user.password = password;
  }
}