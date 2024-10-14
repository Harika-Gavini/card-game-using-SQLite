import 'package:flutter/material.dart';
import 'card_model.dart';
import 'card_database.dart';

class CardDeckScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Card Deck'),
      ),
      body: FutureBuilder<List<CardModel>>(
        future: fetchCardsFromDB(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No cards available.')); // Show message if no cards
          }

          final cards = snapshot.data!;
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: cards.length,
            itemBuilder: (context, index) {
              final card = cards[index];
              return Card(
                child: Column(
                  children: [
                    Image.network(
                      card.imageUrl,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(Icons.error); // Show an error icon if the image fails to load
                      },
                    ),
                    Text(card.name),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<List<CardModel>> fetchCardsFromDB() async {
    final db = await CardDatabase.instance.database;
    final List<Map<String, dynamic>> cardMaps = await db.query('cards');

    // Check if cardMaps is empty and return an empty list
    if (cardMaps.isEmpty) {
      return [];  // Return an empty list instead of null
    }

    return List.generate(cardMaps.length, (index) {
      return CardModel.fromMap(cardMaps[index]);
    });
  }
}
