import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    return android;
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBdFC2HkKRthQ8SO_8ire2V3tiTJ6Uk_1w', // Tu API Key
    appId: '1:276350745055:android:023580ad26d0491ece6c6a', // Tu App ID
    messagingSenderId: '276350745055', // El Project Number (sender ID)
    projectId: 'tp-log-in', // Tu Project ID
    databaseURL:
        'https://tp-log-in.firebaseio.com', // Si usas Realtime Database, cámbialo a la URL correcta
    storageBucket: 'tp-log-in.firebasestorage.app', // Tu Storage Bucket
    measurementId:
        'G-XXXXXXXXXX', // Si usas Google Analytics, reemplázalo por el ID correspondiente
    androidClientId:
        'your-android-client-id', // Opcional: Si usas OAuth, agrega el Client ID
  );
}
