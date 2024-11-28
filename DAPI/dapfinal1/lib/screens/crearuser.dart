import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dapfinal1/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';


class UserScreen extends StatefulWidget {
  static const String name = 'crearusuario';

  const UserScreen({super.key});

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _createUser() async {
  final firestore = FirebaseFirestore.instance; 
  try {
    final String email = emailController.text;
    final String password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Los campos no pueden estar vacíos'),
          backgroundColor: Colors.deepOrange,
        ),
      );
      return;
    }

    final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );


    await firestore.collection('usuarios').doc(userCredential.user!.uid).set({
      'email': email,
      'password': password
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Ya podés entrar pa'),
        backgroundColor: Colors.green,
      ),
    );

    context.pushNamed(LoginScreen.name);

  } on FirebaseAuthException catch (e) {
    String message;
    if (e.code == 'weak-password') {
      message = 'La contraseña es demasiado débil.';
    } else if (e.code == 'email-already-in-use') {
      message = 'El correo electrónico ya está en uso.';
    } else if (e.code == 'invalid-email') {
      message = 'El correo electrónico es inválido.';
    } else {
      message = 'Error: ${e.message}';
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.deepOrange,
      ),
    );
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Crear usuario',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
        ),
        automaticallyImplyLeading: true,
        backgroundColor: const Color.fromARGB(255, 255, 222, 10),
      ),
      backgroundColor: const Color.fromARGB(255, 129, 212, 250),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 50),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Mail',
                    icon: Icon(Icons.mail),
                    iconColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Contraseña',
                    icon: Icon(Icons.lock),
                    iconColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _createUser,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                  ),
                  child: const Text(
                    'Crear usuario',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color.fromARGB(255, 63, 54, 244),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
