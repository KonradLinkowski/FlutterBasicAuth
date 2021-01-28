import 'package:basic_auth/auth.service.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class PasswordScreen extends StatefulWidget {
  PasswordScreen({Key key}) : super(key: key);

  @override
  _PasswordScreenState createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final notepadController = TextEditingController();
  final passwordController = TextEditingController();
  bool loading = false;

  @override
  void initState() {
    super.initState();
  }

  void savePassword() {
    AuthService.instance.savePassword(passwordController.text).then((_) {
      Toast.show('Password changed', context, gravity: Toast.CENTER);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change password'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Enter your new password'),
              controller: passwordController,
              obscureText: true,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: savePassword,
        tooltip: 'Increment',
        child: Icon(Icons.save),
      ),
    );
  }
}
