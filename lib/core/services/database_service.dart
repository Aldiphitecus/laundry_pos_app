import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelpers {
  static final DatabaseHelpers instance = DatabaseHelpers._internal();
  static Database? _database;

  DatabaseHelpers._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'laundry_pos.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE services (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        price INTEGER NOT NULL,
        unit TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE transactions (
        id TEXT PRIMARY KEY,
        transaction_number TEXT NOT NULL,
        customer_name TEXT NOT NULL,
        transaction_date TEXT NOT NULL,
        total INTEGER NOT NULL,
        created_at TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE transaction_items (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        transaction_id TEXT NOT NULL,
        service_id INTEGER NOT NULL,
        service_name TEXT NOT NULL,
        qty REAL NOT NULL,
        unit TEXT NOT NULL,
        price INTEGER NOT NULL,
        total INTEGER NOT NULL,
        FOREIGN KEY (transaction_id) REFERENCES transactions(id) ON DELETE CASCADE,
        FOREIGN KEY (service_id) REFERENCES services(id)
      )
    ''');
  }
}
