import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dapfinal1/screens/crearuser.dart';
import 'package:dapfinal1/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  static const String name = 'login';
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isObscure = true;

  Future<void> _login() async {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  try {
    final String email = userController.text;
    final String password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Campos vacíos'),
          backgroundColor: Colors.deepOrange,
        ),
      );
      return;
    }

    final userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = userCredential.user;    

    if (user != null) {
      await user.reload(); 

          context.pushNamed(HomeScreen.name);
        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('¡Bienvenido de vuelta!'),
            backgroundColor: Colors.deepOrange,
          ),
        );    
    }
  } on FirebaseAuthException catch (e) {
    String message = '¡Algo no está bien!';

    if (e.code == 'user-disabled') {
      message = 'Tu cuenta ha sido suspendida';
    } else if (e.code == 'wrong-password' && e.code == 'user-not-found') {
      message = 'Contraseña y/o usuario incorrectos';
    } else if (e.code == 'invalid-email') {
      message = 'El correo electrónico es inválido';
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
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Color.fromARGB(255, 129, 212, 250),
              Color.fromARGB(255, 243, 255, 132), 
              Color(0xFF81D4FA),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          
          child: ListView(
            
            children: [

              SizedBox(
                width: 250,
                height: 300,
                child: Image.asset("assets/images/messisi.png"),
              ),
              const SizedBox(height: 50),
          
              
                Center(
                  child: const Text(
                    'Logueate rey',
                    style: TextStyle(
                      color: Color.fromARGB(255, 4, 0, 0),
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),              
              const SizedBox(height: 30),

              TextField(
                controller: userController,
                decoration: InputDecoration(
                  hintText: 'Usuario',
                  prefixIcon: const Icon(Icons.person, color: Colors.blueGrey),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20.0),

              
              TextField(
                controller: passwordController,
                obscureText: _isObscure,
                decoration: InputDecoration(
                  hintText: 'Contraseña',
                  prefixIcon: const Icon(Icons.lock, color: Colors.blueGrey),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isObscure ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 30.0),

      Row(
  mainAxisAlignment: MainAxisAlignment.end, 
  children: [
    RichText(
      text: TextSpan(       
        text: '',
        style: const TextStyle(color: Colors.white, fontSize: 13),
        children: <TextSpan>[          
          TextSpan(
            text: 'Crear usuario',
            style: const TextStyle(
              color: Color.fromARGB(255, 255, 0, 0),
              fontSize: 13,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                context.pushNamed(UserScreen.name);
              },
          ),
        ],
      ),
    ),
  ],
),
const SizedBox(height: 40.0),
             
     ElevatedButton(
      onPressed: _login,
      child: const Text(
      'Iniciar sesión',
      style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
  ), ),
 ),
  const SizedBox(height: 7),
            ],
          ),
        ),
      ),
    );
  }
}

