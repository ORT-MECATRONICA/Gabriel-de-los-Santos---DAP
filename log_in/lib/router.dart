import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:log_in/pantallas/login.dart';
import 'package:log_in/pantallas/home.dart'; // Asegúrate de importar tu archivo Home

void main() {
  final GoRouter _router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const Login(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const Home(),
      ),
    ],
  );

  runApp(MyApp(router: _router));
}

class MyApp extends StatelessWidget {
  final GoRouter router;

  const MyApp({super.key, required this.router});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'Flutter App',
    );
  }
}
