import 'package:flutter/material.dart';
import 'package:log_in/elementos/jugadoresdata.dart';

// ignore: must_be_immutable
class JugadoresInfo extends StatelessWidget {
  static const String nombre = 'jugadoresinfo';

  final Jugadores jugadoresInfo;

  const JugadoresInfo({super.key, required this.jugadoresInfo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jugador Info'),
      ),
      body: Container(
        color: const Color.fromARGB(255, 182, 182, 182),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: ListView(
              children: [
                Image.network(
                  jugadoresInfo.urlcara ?? 'https://via.placeholder.com/150',
                  height: 200,
                ),
                const SizedBox(height: 16),
                Text(
                  jugadoresInfo.nombre,
                  style: const TextStyle(
                    color: Color.fromRGBO(1, 1, 1, 1),
                    fontFamily: 'OpenSans',
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 12),
                Text(
                  'Posición: ${jugadoresInfo.posicion}',
                  style: const TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontFamily: 'OpenSans',
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 12),
                Text(
                  'País: ${jugadoresInfo.pais}',
                  style: const TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontFamily: 'OpenSans',
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 16),
                Image.network(
                  jugadoresInfo.urlequipo,
                  height: 100,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
