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
  UserModel _data = UserModel();

  void login() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    bool success = AuthService.instance.login(this._data.username, this._data.password);
    if (success) {
      _formKey.currentState.reset();
      Navigator.pushNamed(context, '/notepad');
      Toast.show('Successful login', context);
    } else {
      Toast.show('Wrong credentials', context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test login'),
      ),
      body: Container(
        margin: EdgeInsets.all(50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                onSaved: (value) => this._data.username = value,
                decoration: InputDecoration(
                  labelText: 'Enter your username'
                ),
              ),
              TextFormField(
                obscureText: true,
                onSaved: (value) => this._data.password = value,
                decoration: InputDecoration(
                    labelText: 'Enter your password'
                ),
              ),
              MaterialButton(
                child: Text("Login"),
                textColor: Colors.white,
                color: Colors.blue,
                onPressed: this.login,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
