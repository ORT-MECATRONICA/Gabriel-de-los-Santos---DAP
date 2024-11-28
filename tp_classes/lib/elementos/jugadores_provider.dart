import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:log_in/elementos/jugadoresdata.dart';

// StateNotifier para manejar la lista de jugadores
class JugadoresNotifier extends StateNotifier<List<Jugadores>> {
  JugadoresNotifier() : super(jugadoresList);

  void agregarJugador(Jugadores jugador) {
    state = [...state, jugador];
  }

  void editarJugador(int index, Jugadores jugadorEditado) {
    state = [
      for (int i = 0; i < state.length; i++)
        if (i == index) jugadorEditado else state[i]
    ];
  }

  void eliminarJugador(int index) {
    state = [
      for (int i = 0; i < state.length; i++)
        if (i != index) state[i]
    ];
  }
}

// El Provider que manejará la lista de jugadores
final jugadoresProvider =
    StateNotifierProvider<JugadoresNotifier, List<Jugadores>>((ref) {
  return JugadoresNotifier();
});
