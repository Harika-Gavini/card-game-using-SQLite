import 'package:flutter/material.dart';
import 'card_database.dart';
import 'card_deck_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final db = CardDatabase.instance;
  await db.insertInitialCards(); // Populate initial cards on app launch
  runApp(CardsActivityApp());
}

class CardsActivityApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cards Activity App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CardDeckScreen(), // Set your home screen
    );
  }
}
