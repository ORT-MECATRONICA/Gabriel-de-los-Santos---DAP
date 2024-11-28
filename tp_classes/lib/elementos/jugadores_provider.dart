import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:log_in/elementos/jugadoresdata.dart';

final jugadoresProvider = StateNotifierProvider<JugadoresNotifier, List<Jugadores>>((ref) {
  return JugadoresNotifier();
});

class JugadoresNotifier extends StateNotifier<List<Jugadores>> {
  JugadoresNotifier() : super([]);

  // Cargar jugadores desde Firestore
  Future<void> cargarJugadores() async {
    try {
      final snapshot = await FirebaseFirestore.instance.collection('jugadores').get();
      final jugadoresList = snapshot.docs.map((doc) {
        final data = doc.data();
        return Jugadores(
          nombre: data['nombre'],
          posicion: data['posicion'],
          pais: data['pais'],
          urlequipo: data['urlequipo'],
          urlcara: data['urlcara'],
        );
      }).toList();
      state = jugadoresList;
    } catch (e) {
      print("Error cargando jugadores: $e");
    }
  }

  // Agregar jugador a Firestore
  Future<void> agregarJugador(Jugadores jugador) async {
    try {
      await FirebaseFirestore.instance.collection('jugadores').add({
        'nombre': jugador.nombre,
        'posicion': jugador.posicion,
        'pais': jugador.pais,
        'urlequipo': jugador.urlequipo,
        'urlcara': jugador.urlcara ?? '',
      });
      await cargarJugadores();
    } catch (e) {
      print("Error agregando jugador: $e");
    }
  }

  // Eliminar jugador de Firestore
  Future<void> eliminarJugador(int index) async {
    try {
      final jugador = state[index];
      await FirebaseFirestore.instance
          .collection('jugadores')
          .doc(jugador.nombre) // Este método asume que cada jugador tiene un campo `id` único
          .delete();
      await cargarJugadores();
    } catch (e) {
      print("Error eliminando jugador: $e");
    }
  }

  // Editar jugador en Firestore
  Future<void> editarJugador(int index, Jugadores jugador) async {
    try {
      final jugadorOriginal = state[index];
      await FirebaseFirestore.instance
          .collection('jugadores')
          .doc(jugadorOriginal.nombre)
          .update({
        'nombre': jugador.nombre,
        'posicion': jugador.posicion,
        'pais': jugador.pais,
        'urlequipo': jugador.urlequipo,
        'urlcara': jugador.urlcara ?? '',
      });
      await cargarJugadores();
    } catch (e) {
      print("Error editando jugador: $e");
    }
  }
}
