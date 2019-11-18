import 'package:basic_auth/file.service.dart';
import 'package:flutter/material.dart';
import 'auth.service.dart';
import 'package:toast/toast.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String password;

  Future<void> login() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    final bool success = await AuthService.instance.login(this.password);
    final bool hasPassword = (await AuthService.instance.storage.read(key: 'password')) != null ? true : false;
    if (success) {
      _formKey.currentState.reset();
      Navigator.pushNamed(context, hasPassword ? '/notepad' : '/password');
      Toast.show('Successful login', context, gravity: Toast.CENTER);
    } else {
      Toast.show('Wrong credentials', context, gravity: Toast.CENTER);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
        margin: EdgeInsets.all(50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                obscureText: true,
                onSaved: (value) => this.password = value,
                decoration: InputDecoration(
                    labelText: 'Enter your password'
                ),
              ),
              MaterialButton(
                child: Text("Login"),
                textColor: Colors.white,
                color: Colors.blue,
                onPressed: () async {
                  await this.login();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
