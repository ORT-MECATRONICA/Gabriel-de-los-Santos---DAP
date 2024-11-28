import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddMemeScreen extends StatelessWidget {
  static const String name = 'addmeme';

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController(); 

  AddMemeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Película'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Título',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Descripción',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            
            TextField(
              controller: _imageUrlController,
              decoration: const InputDecoration(
                labelText: 'URL de la imagen',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            
            ElevatedButton(
              onPressed: () async {
                if (_titleController.text.isNotEmpty && _imageUrlController.text.isNotEmpty) {
                  
                  await FirebaseFirestore.instance.collection('memes').add({
                    'title': _titleController.text,
                    'description': _descriptionController.text,
                    'imageUrl': _imageUrlController.text,  
                    'timestamp': FieldValue.serverTimestamp(),
                  });
                  Navigator.pop(context);  
                } else {
                  
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Por favor ingrese todos los campos.')),
                  );
                }
              },
              child: const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}

