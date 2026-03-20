import 'package:path/path.dart';
import 'package:rivamiru/models/animeinterface.dart';
import 'package:sqflite/sqflite.dart';

class AnimeDatabase {
  static Database? _db;
  static final AnimeDatabase _instance = AnimeDatabase._init();

  factory AnimeDatabase() {
    return _instance;
  }

  AnimeDatabase._init();

  Future<Database> get db async {
    if (_db != null) return _db!;

    _db = await _initDb('anime.db');
    return _db!;
  }

  Future<Database> _initDb(String path) async {
    return await openDatabase(
      join(await getDatabasesPath(), path),
      version: 1,
      onCreate: _createDb,
    );
  }

  Future<void> _createDb(Database db, int version) async {
    final create = """
      CREATE TABLE anime (
        id INTEGER PRIMARY KEY,
        name TEXT NOT NULL,
        description TEXT,
        imageUrl TEXT
      )""";

    await db.execute(create);
  }

  Future<int> addAnime(Anime anime) async {
    final db = await _instance.db;
    return await db.insert('anime', anime.map());
  }

  Future<int> deleteAnime(Anime anime) async {
    final db = await _instance.db;
    return await db.delete('anime', where: 'id = ?', whereArgs: [anime.id]);
  }

  Future<void> close() async {
    final db = await _instance.db;
    db.close();
  }

  Future<List<Anime>> getAllAnime() async {
    final db = await _instance.db;
    final res = await db.query('anime');

    return res.map((e) => Anime.fromMap(e)).toList();
  }

  Future<bool> isAnimePresent(int id) async {
    final db = await _instance.db;

    final List<Map<String, dynamic>> res = await db.query(
      'anime',
      where: 'id = ?',
      whereArgs: [id],
    );

    return res.isNotEmpty;
  }
}
