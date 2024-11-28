import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Importar Riverpod
import 'package:firebase_core/firebase_core.dart'; // Importar Firebase Core
import 'package:tp_final/router.dart'; // Importar la configuración de rutas

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Inicializa Firebase

  runApp(const ProviderScope(child: MainApp())); // Envolver la aplicación en ProviderScope
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
