import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:log_in/pantallas/home.dart';
import 'package:log_in/elementos/logindata.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Login extends StatelessWidget {
  static const String name = 'login';
  Login({super.key});
  final TextEditingController usuarioController = TextEditingController();
  final TextEditingController contrasenaController = TextEditingController();

  final TextEditingController registroUsuarioController = TextEditingController();
  final TextEditingController registroContrasenaController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 190, 190, 190),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 50),
              const Icon(
                Icons.phone_iphone,
                size: 125,
                color: Color.fromRGBO(0, 0, 0, 1),
              ),
              const SizedBox(height: 50),
              const Text(
                '¡Bienvenido de vuelta!',
                style: TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 1),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  controller: usuarioController,
                  decoration: const InputDecoration(
                    hintText: 'Usuario',
                    filled: true,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  controller: contrasenaController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'Contraseña',
                    filled: true,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final usuario = usuarioController.text;

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Home(userName: usuario),
                    ),
                  );
                },
                child: const Text('Entrar'),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  _mostrarFormularioRegistro(context);
                },
                child: const Text('¿No tienes cuenta? Regístrate'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _mostrarFormularioRegistro(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Registro'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: registroUsuarioController,
                decoration: const InputDecoration(labelText: 'Usuario'),
              ),
              TextField(
                controller: registroContrasenaController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Contraseña'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                final nombreUsuario = registroUsuarioController.text;
                final contrasena = registroContrasenaController.text;
                FirebaseFirestore.instance.collection('usuarios').add({
                  'usuario': nombreUsuario,
                  'contrasena': contrasena,
                });
                Navigator.of(context).pop();
              },
              child: const Text('Registrar'),
            ),
          ],
        );
      },
    );
  }
}
