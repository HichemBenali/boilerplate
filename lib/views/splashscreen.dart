import 'package:boilerplate/views/login.dart';

import '../services/auth.dart';
import '../views/home.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  _splash() {
    return Scaffold(body: Container());
  }

  Widget _load(BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.connectionState == ConnectionState.done) {
      if (snapshot.data) {
        return HomePage();
      } else {
        return LoginPage();
      }
    } else {
      return _splash();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        builder: _load, future: AuthService().isAuthenticated());
  }
}
