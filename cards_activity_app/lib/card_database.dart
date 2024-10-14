import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'card_model.dart';

class CardDatabase {
  static final CardDatabase instance = CardDatabase._init();
  static Database? _database;

  CardDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'cards.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE cards (
        id INTEGER PRIMARY KEY,
        name TEXT,
        imageUrl TEXT
      )
    ''');
  }

  Future<void> insertInitialCards() async {
    final db = await database;

    // Sample data
    List<CardModel> initialCards = [
      
  CardModel(id: 1, name: 'Ace of Spades', imageUrl: 'https://en.wiktionary.org/wiki/ace_of_spades#/media/File:Poker-sm-211-As.png'),
  CardModel(id: 2, name: 'King of Hearts', imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/7/79/Poker-sm-222-Kh.png'),
  CardModel(id: 3, name: 'Queen of Diamonds', imageUrl: 'https://en.wiktionary.org/wiki/queen_of_diamonds#/media/File:Poker-sm-233-Qd.png'),
  CardModel(id: 4, name: 'Jack of Clubs', imageUrl: 'https://en.wiktionary.org/wiki/jack_of_clubs#/media/File:Poker-sm-244-Jc.png'),
];


    // Insert each card
    for (var card in initialCards) {
      await db.insert('cards', card.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  Future<List<CardModel>> fetchCardsFromDB() async {
    final db = await database;
    final List<Map<String, dynamic>> cardMaps = await db.query('cards');

    if (cardMaps.isEmpty) {
      return []; // Return an empty list if no cards are found
    }

    return List.generate(cardMaps.length, (index) {
      return CardModel.fromMap(cardMaps[index]);
    });
  }
}
