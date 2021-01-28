import 'package:basic_auth/password.dart';
import 'package:flutter/material.dart';

import 'login.dart';
import 'notepad.dart';

void main() {
  runApp(MaterialApp(
    title: 'My notepad',
    initialRoute: '/',
    routes: {
      '/password': (context) => PasswordScreen(),
      '/notepad': (context) => NotepadScreen(),
      '/': (context) => LoginScreen(),
    },
  ));
}
