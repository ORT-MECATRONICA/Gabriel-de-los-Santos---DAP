import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:log_in/elementos/jugadoresdata.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class JugadoresNotifier extends StateNotifier<List<Jugadores>> {
  JugadoresNotifier() : super([]) {
    sincronizarJugadores();
  }

  final _firestore = FirebaseFirestore.instance;

  void agregarJugador(Jugadores jugador) async {
    state = [...state, jugador];
    await _firestore.collection('jugadores').add({
      'nombre': jugador.nombre,
      'posicion': jugador.posicion,
      'pais': jugador.pais,
      'urlequipo': jugador.urlequipo,
      'urlcara': jugador.urlcara,
    });
  }

  void editarJugador(int index, Jugadores jugadorEditado) async {
    final docId = await obtenerDocIdPorIndex(index);
    if (docId != null) {
      await _firestore.collection('jugadores').doc(docId).update({
        'nombre': jugadorEditado.nombre,
        'posicion': jugadorEditado.posicion,
        'pais': jugadorEditado.pais,
        'urlequipo': jugadorEditado.urlequipo,
        'urlcara': jugadorEditado.urlcara,
      });
      sincronizarJugadores();
    }
  }

  Future<String?> obtenerDocIdPorIndex(int index) async {
    final snapshot = await _firestore.collection('jugadores').get();
    if (index < snapshot.docs.length) {
      return snapshot.docs[index].id;
    }
    return null;
  }

  void sincronizarJugadores() async {
    final snapshot = await _firestore.collection('jugadores').get();
    state = snapshot.docs.map((doc) {
      final data = doc.data();
      return Jugadores(
        nombre: data['nombre'],
        posicion: data['posicion'],
        pais: data['pais'],
        urlequipo: data['urlequipo'],
        urlcara: data['urlcara'],
      );
    }).toList();
  }

  void eliminarJugador(int index) async {
    final docId = await obtenerDocIdPorIndex(index);
    if (docId != null) {
      await _firestore.collection('jugadores').doc(docId).delete();
      sincronizarJugadores();
    }
  }
}

final jugadoresProvider =
    StateNotifierProvider<JugadoresNotifier, List<Jugadores>>((ref) {
  return JugadoresNotifier();
});
