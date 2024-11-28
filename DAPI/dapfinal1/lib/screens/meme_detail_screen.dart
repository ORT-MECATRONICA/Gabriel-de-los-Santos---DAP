import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'meme_provider.dart';
import 'meme.dart';

class MemeDetailScreen extends StatefulWidget {
  final Meme meme;
  

  const MemeDetailScreen({required this.meme, Key? key}) : super(key: key);

  @override
  _MemeDetailScreenState createState() => _MemeDetailScreenState();
}

class _MemeDetailScreenState extends State<MemeDetailScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _imageUrlController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.meme.title);
    _descriptionController = TextEditingController(text: widget.meme.description);
    _imageUrlController = TextEditingController(text: widget.meme.imageUrl);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final memeProvider = Provider.of<MemeProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: Text(widget.meme.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Imagen cargada desde URL
            Image.network(
              widget.meme.imageUrl,
              height: 300,
            ),
            const SizedBox(height: 16),

            // Campo para editar el título
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Título'),
            ),
            const SizedBox(height: 16),

           
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Descripción'),
            ),
            const SizedBox(height: 16),

            
            TextField(
              controller: _imageUrlController,
              decoration: const InputDecoration(labelText: 'URL de la imagen'),
              onChanged: (value) {
                setState(() {}); 
              },
            ),
            const SizedBox(height: 16),

            
            ElevatedButton(
              onPressed: () async {
                widget.meme.title = _titleController.text;
                widget.meme.description = _descriptionController.text;
                widget.meme.imageUrl = _imageUrlController.text;

                await memeProvider.updateMeme(widget.meme);
                Navigator.of(context).pop();
              },
              child: const Text('Actualizar datos'),
            ),

            // Botón para eliminar
            ElevatedButton(
              onPressed: () async {
                await memeProvider.deleteMeme(widget.meme.id);
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 255, 17, 0),
              ),
              child: const Text(
                'Eliminar',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
