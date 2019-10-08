import 'package:flutter/material.dart';

import 'login.dart';
import 'notepad.dart';
import 'auth.service.dart';

void main() {
  runApp(MaterialApp(
    title: 'Named Routes Demo',
    initialRoute: '/',
    routes: {
      '/notepad': AuthService.instance.isAuthenticated ? (context) => NotepadScreen() : LoginScreen(),
      '/': (context) => LoginScreen(),
    },
  ));
}

