import 'package:dapfinal1/core/go_router.dart';
import 'package:dapfinal1/screens/meme_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MemeProvider()), // Aquí agregamos el provider
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter, // Aquí usas tu router de go_router como lo tenías
      debugShowCheckedModeBanner: false,
    );
  }
}
