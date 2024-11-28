import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Importar Riverpod
import 'package:log_in/router.dart'; // Importar la configuración de rutas

void main() {
  runApp(const ProviderScope(
      child: MainApp())); // Envolver la aplicación en ProviderScope
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter, // Configuración de rutas
      debugShowCheckedModeBanner: false, // Ocultar el banner de debug
    );
  }
}
