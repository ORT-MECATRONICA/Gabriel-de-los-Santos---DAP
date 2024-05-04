import 'package:log_in/pantallas/home.dart';
import 'package:log_in/pantallas/login.dart';

import 'package:go_router/go_router.dart';

final appRouter = GoRouter(initialLocation: '/login', routes: [
  GoRoute(
    name: Login.name,
    path: '/login',
    builder: (context, state) => Login(),
  ),
  GoRoute(
    name: Home.name,
    path: '/home',
    builder: (context, state) => Home(userName: state.extra as String),
  ),
]);
