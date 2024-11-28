import 'package:flutter/material.dart';
import 'package:log_in/pantallas/login.dart'; // Asegúrate de importar tu archivo de Login
import 'package:log_in/pantallas/home.dart'; // Asegúrate de importar la pantalla de Home

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (context) => const Login());
          case '/home':
            return MaterialPageRoute(builder: (context) => const Home());
          default:
            return MaterialPageRoute(builder: (context) => const Login());
        }
      },
    );
  }
}
