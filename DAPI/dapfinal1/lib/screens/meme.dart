class Meme {
  String id;
  String title;
  String description;
  String imageUrl;

  static var length;

  Meme({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  factory Meme.fromDocument(String id, Map<String, dynamic> data) {
    return Meme(
      id: id,
      title: data['title'] ?? '',
      description: data['description'] ?? '', 
      imageUrl: data['imageUrl'] ?? '',

    );
  }
}
