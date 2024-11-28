import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dapfinal1/core/go_router.dart';
import 'package:dapfinal1/screens/add_meme_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'meme_detail_screen.dart';
import 'meme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key); 
  static const String name = 'home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _addmeme() async {
    String title = '';
    String description = '';
    String imageUrl = '';

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Meme argentino'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Titulo'),
                onChanged: (value) => title = value,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Descripcion'),
                onChanged: (value) => description = value,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'URL de imagen'),
                onChanged: (value) => imageUrl = value,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (title.isNotEmpty && description.isNotEmpty && imageUrl.isNotEmpty) {
                  await _firestore.collection('memes').add({
                    'title': title,
                    'description': description,
                    'imageUrl': imageUrl,                  
                  });
                }
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          'Memes argentinos',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      
      backgroundColor: Colors.lightBlue,
      
      body: StreamBuilder<QuerySnapshot>(
  stream: _firestore.collection('memes').orderBy('timestamp', descending: true).snapshots(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    }

    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
      return const Center(
        child: Text(
          'No me la contes, nos quedamos sin memes',
          style: TextStyle(fontSize: 18),
        ),
      );
    }

    final memes = snapshot.data!.docs.map((doc) {
      return Meme.fromDocument(doc.id, doc.data() as Map<String, dynamic>);
    }).toList();

    return ListView.builder(
      itemCount: memes.length,
      itemBuilder: (context, index) {
        final meme = memes[index];
        
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),  
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0), 
          ),
          elevation: 5,  
          child: ListTile(
            contentPadding: const EdgeInsets.all(16.0),  
            title: Text(
              meme.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(meme.description),  
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MemeDetailScreen(meme: meme),
                ),
              );
            },
          ),
        );
        
      },     
    );
  },
),
floatingActionButton: FloatingActionButton(
    onPressed: () {
      context.pushNamed(AddMemeScreen.name);
    },
    backgroundColor: const Color.fromARGB(255, 225, 255, 0),
    child: const Icon(Icons.add),  
  ),
    );
    }
    }