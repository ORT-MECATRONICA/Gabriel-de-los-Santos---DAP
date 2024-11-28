import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Registrar un nuevo usuario
  Future<void> registrarUsuario(String usuario, String contrasena) async {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: '$usuario@example.com', // Firebase requiere emails
      password: contrasena,
    );

    await _firestore.collection('Users').doc(userCredential.user!.uid).set({
      'Users': usuario,
    });
  }

  // Iniciar sesión
  Future<void> iniciarSesion(String usuario, String contrasena) async {
    await _auth.signInWithEmailAndPassword(
      email: '$usuario@example.com',
      password: contrasena,
    );
  }
}
