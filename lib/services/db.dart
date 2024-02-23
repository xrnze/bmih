import 'package:bmih/model/bmi.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static final DatabaseService _databaseService = DatabaseService._internal();
  factory DatabaseService() => _databaseService;
  DatabaseService._internal();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    // Initialize the DB first time it is accessed
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();

    final path = join(databasePath, 'flutter_sqflite_database.db');

    return await openDatabase(
      path,
      onCreate: _onCreate,
      version: 1,
      onConfigure: (db) async => await db.execute('PRAGMA foreign_keys = ON'),
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE calculations(id TEXT PRIMARY KEY, gender INTEGER, height INTEGER, weight INTEGER, result REAL, date INTEGER)',
    );
  }

  Future<void> save(Calculation calculation) async {
    // Get a reference to the database.
    final db = await _databaseService.database;

    if (calculation.id.isEmpty) {
      throw "Error";
    }

    await db.insert(
      'calculations',
      calculation.toMap(),
      conflictAlgorithm: ConflictAlgorithm.abort,
    );
  }

  Future<List<Calculation>> savedResults() async {
    final db = await _databaseService.database;

    final List<Map<String, dynamic>> maps =
        await db.rawQuery('SELECT * FROM calculations ORDER BY date ASC');
    print(maps);

    return List.generate(
        maps.length, (int index) => Calculation.fromMap(maps[index]));
  }

  Future<void> deleteResult(String id) async {
    final db = await _databaseService.database;

    // Remove the Breed from the database.
    await db.delete(
      'calculations',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
