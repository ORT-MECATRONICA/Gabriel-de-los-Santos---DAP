import 'package:flutter/material.dart';
import 'package:log_in/elementos/auth_provider.dart';

class Login extends StatefulWidget {
  static const String name = 'login';

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _contrasenaController = TextEditingController();
  final AuthService _authService = AuthService();

  void _mostrarRegistroDialog() {
    showDialog(
      context: context,
      builder: (context) {
        final TextEditingController _nuevoUsuarioController =
            TextEditingController();
        final TextEditingController _nuevaContrasenaController =
            TextEditingController();

        return AlertDialog(
          title: const Text('Registrar nueva cuenta'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nuevoUsuarioController,
                decoration: const InputDecoration(labelText: 'Usuario'),
              ),
              TextField(
                controller: _nuevaContrasenaController,
                decoration: const InputDecoration(labelText: 'Contraseña'),
                obscureText: true,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                try {
                  await _authService.registrarUsuario(
                    _nuevoUsuarioController.text,
                    _nuevaContrasenaController.text,
                  );
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Cuenta registrada con éxito')),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: $e')),
                  );
                }
              },
              child: const Text('Registrar'),
            ),
          ],
        );
      },
    );
  }

  void _iniciarSesion() async {
    try {
      await _authService.iniciarSesion(
        _usuarioController.text,
        _contrasenaController.text,
      );
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usuarioController,
              decoration: const InputDecoration(labelText: 'Usuario'),
            ),
            TextField(
              controller: _contrasenaController,
              decoration: const InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: _iniciarSesion,
              child: const Text('Iniciar Sesión'),
            ),
            TextButton(
              onPressed: _mostrarRegistroDialog,
              child: const Text('Crear nueva cuenta'),
            ),
          ],
        ),
      ),
    );
  }
}
