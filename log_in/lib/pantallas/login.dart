import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:log_in/pantallas/home.dart';
import 'package:log_in/elementos/logindata.dart';

class Login extends StatelessWidget {
  static const String name = 'login';
  Login({super.key});
  final TextEditingController usuarioController = TextEditingController();
  final TextEditingController contrasenaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 190, 190, 190),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 50), //Sirve para dejar espacios
              const Icon(
                Icons.phone_iphone,
                size: 125,
                color: Color.fromRGBO(0, 0, 0, 1),
              ),
              const SizedBox(height: 50),

              const Text(
                //Texto de bienvenida
                '¡Bienvenido de vuelta!',
                style: TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 1),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              Padding(
                //Bloque de texto de contraseña
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  controller: usuarioController,
                  obscureText: false,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromRGBO(255, 255, 255, 1)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromRGBO(0, 0, 0, 1), width: 2.5),
                    ),
                    fillColor: Color.fromRGBO(255, 255, 255, 1),
                    filled: true,
                    hintText: 'Usuario',
                  ),
                ),
              ),

              const SizedBox(height: 5),

              Padding(
                //Bloque de texto de contraseña
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  controller: contrasenaController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromRGBO(255, 255, 255, 1)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromRGBO(0, 0, 0, 1), width: 2.5),
                    ),
                    fillColor: Color.fromRGBO(255, 255, 255, 1),
                    filled: true,
                    hintText: 'Contraseña',
                  ),
                ),
              ),

              const SizedBox(height: 2),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Text(
                    '¿Olvidaste tu contraseña?',
                    style: TextStyle(color: Color.fromRGBO(206, 206, 206, 1)),
                  )
                ]),
              ),

              const SizedBox(height: 10),

              ElevatedButton(
                onPressed: () {
                  String inputUser = usuarioController.text;
                  String inputPass = contrasenaController.text;

                  final perfilData = logInList.firstWhere(
                      (perfilData) => perfilData.usuario == inputUser);

                  if (inputPass.isEmpty || inputUser.isEmpty) {
                    print("Por favor, ingrese Usuario y/o Contraseña");
                    const Text(
                      'Por favor, ingrese el usuario y/o contraseña',
                      style: TextStyle(color: Colors.red),
                    );
                  } else if (perfilData.usuario == inputUser &&
                      perfilData.contrasena == inputPass) {
                    print("Log In exitoso");
                    context.pushNamed(Home.name, extra: inputUser);
                  } else {
                    print("Log In fallido");
                  }
                },
                child: const Text(
                  'Log In',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
