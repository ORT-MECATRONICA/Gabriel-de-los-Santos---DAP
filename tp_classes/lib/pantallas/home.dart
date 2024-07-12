import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:log_in/elementos/jugadoresdata.dart';
import 'package:log_in/pantallas/jugadoresinfo.dart';

// ignore: must_be_immutable
class Home extends StatelessWidget {
  static const String name = 'home';
  String userName;
  Home({super.key, this.userName = ''});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 199, 199, 199),
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Container(
        color: const Color.fromRGBO(73, 73, 73, 1),
        child: ListView.builder(
          itemCount: jugadoresList.length,
          itemBuilder: (context, index) {
            Jugadores jugadoresElemento = jugadoresList[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 140, // Ajusta la altura del Card según tus necesidades
                child: Card(
                  color: const Color.fromARGB(255, 126, 126, 126),
                  shadowColor: const Color.fromRGBO(1, 1, 1, 1),
                  surfaceTintColor: const Color.fromRGBO(255, 255, 255, 1),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 200,
                        width: 100, // Ancho fijo para la imagen
                        child: jugadoresElemento.urlcara != null
                            ? _imagen(jugadoresElemento.urlcara!)
                            : const Icon(Icons.sports_soccer_rounded),
                      ),
                      Expanded(
                        child: ListTile(
                          title: Text(jugadoresElemento.nombre),
                          subtitle: Text('País: ${jugadoresElemento.pais}'),
                          onTap: () => context.pushNamed(
                            JugadoresInfo.nombre,
                            extra: jugadoresElemento,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _imagen(String urlcara) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4.0),
      child: Image.network(
        urlcara,
        fit: BoxFit.cover, // Ajusta la imagen para cubrir el espacio
      ),
    );
  }
}
