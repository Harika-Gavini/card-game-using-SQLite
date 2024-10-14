class CardModel {
  final int id;
  final String name;
  final String imageUrl;

  CardModel({required this.id, required this.name, required this.imageUrl});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
    };
  }

  static CardModel fromMap(Map<String, dynamic> map) {
    return CardModel(
      id: map['id'],
      name: map['name'],
      imageUrl: map['imageUrl'],
    );
  }
}
