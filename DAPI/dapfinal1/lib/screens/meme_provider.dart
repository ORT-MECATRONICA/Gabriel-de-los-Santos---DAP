import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'meme.dart';

class MemeProvider with ChangeNotifier {
  Future<void> updateMeme(Meme meme) async {
    await FirebaseFirestore.instance.collection('memes').doc(meme.id).update({
      'title': meme.title,
      'description': meme.description,
      'imageUrl': meme.imageUrl,
    });
    notifyListeners();
  }

  Future<void> deleteMeme(String id) async {
    await FirebaseFirestore.instance.collection('memes').doc(id).delete();
    notifyListeners();
  }
}
