import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:log_in/elementos/jugadoresdata.dart';
import 'package:log_in/elementos/jugadores_provider.dart';
import 'package:log_in/pantallas/jugadoresinfo.dart';

// Convertir Home en ConsumerWidget para escuchar los cambios del provider
class Home extends ConsumerWidget {
  static const String name = 'home';
  final String userName;

  Home({super.key, this.userName = ''});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jugadoresList = ref.watch(jugadoresProvider);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 199, 199, 199),
      appBar: AppBar(
        title: Text('Bienvenido $userName'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _agregarJugador(context, ref),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: jugadoresList.length,
        itemBuilder: (context, index) {
          final jugador = jugadoresList[index];
          return Card(
            child: ListTile(
              leading: jugador.urlcara != null
                  ? Image.network(jugador.urlcara!)
                  : const Icon(Icons.sports_soccer_rounded),
              title: Text(jugador.nombre),
              subtitle: Text('País: ${jugador.pais}'),
              onTap: () => context.pushNamed(
                JugadoresInfo.nombre,
                extra: jugador,
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => _editarJugador(context, ref, index),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => ref
                        .read(jugadoresProvider.notifier)
                        .eliminarJugador(index),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _agregarJugador(BuildContext context, WidgetRef ref) {
    _mostrarFormularioJugador(context, ref, isEdit: false);
  }

  void _editarJugador(BuildContext context, WidgetRef ref, int index) {
    _mostrarFormularioJugador(context, ref, isEdit: true, index: index);
  }

  void _mostrarFormularioJugador(BuildContext context, WidgetRef ref,
      {bool isEdit = false, int? index}) {
    final nombreController = TextEditingController();
    final posicionController = TextEditingController();
    final paisController = TextEditingController();
    final urlequipoController = TextEditingController();
    final urlcaraController = TextEditingController();

    if (isEdit) {
      final jugador = ref.read(jugadoresProvider)[index!];
      nombreController.text = jugador.nombre;
      posicionController.text = jugador.posicion;
      paisController.text = jugador.pais;
      urlequipoController.text = jugador.urlequipo;
      urlcaraController.text = jugador.urlcara ?? '';
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(isEdit ? 'Editar Jugador' : 'Agregar Jugador'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: nombreController,
                  decoration: const InputDecoration(labelText: 'Nombre'),
                ),
                TextField(
                  controller: posicionController,
                  decoration: const InputDecoration(labelText: 'Posición'),
                ),
                TextField(
                  controller: paisController,
                  decoration: const InputDecoration(labelText: 'País'),
                ),
                TextField(
                  controller: urlequipoController,
                  decoration: const InputDecoration(labelText: 'URL Equipo'),
                ),
                TextField(
                  controller: urlcaraController,
                  decoration: const InputDecoration(labelText: 'URL Cara'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                final nuevoJugador = Jugadores(
                  nombre: nombreController.text,
                  posicion: posicionController.text,
                  pais: paisController.text,
                  urlequipo: urlequipoController.text,
                  urlcara: urlcaraController.text.isEmpty
                      ? null
                      : urlcaraController.text,
                );

                if (isEdit) {
                  ref
                      .read(jugadoresProvider.notifier)
                      .editarJugador(index!, nuevoJugador);
                } else {
                  ref
                      .read(jugadoresProvider.notifier)
                      .agregarJugador(nuevoJugador);
                }

                Navigator.of(context).pop();
              },
              child: Text(isEdit ? 'Guardar' : 'Agregar'),
            ),
          ],
        );
      },
    );
  }
}
