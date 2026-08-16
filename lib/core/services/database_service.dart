import 'package:dartz/dartz.dart';
import 'package:laundry_pos_app/models/service_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._internal();
  static Database? _database;

  DatabaseService._internal();

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
  }

  Future<Either<String, int>> insertService(ServiceModel service) async {
    try {
      final db = await database;
      final id = await db.insert('services', service.toMap());
      return Right(id);
    } catch (e) {
      return Left('Gagal menyimpan layanan: $e');
    }
  }

  Future<Either<String, List<ServiceModel>>> getAllServices() async {
    try {
      final db = await database;
      final result = await db.query('services');
      final services = result.map((map) => ServiceModel.fromMap(map)).toList();
      return Right(services);
    } catch (e) {
      return Left('Gagal mengambil data layanan: $e');
    }
  }

  Future<Either<String, int>> updateService(ServiceModel service) async {
    try {
      final db = await database;
      final rowsAffected = await db.update(
        'services',
        service.toMap(),
        where: 'id = ?',
        whereArgs: [service.id],
      );
      return Right(rowsAffected);
    } catch (e) {
      return Left('Gagal mengubah layanan: $e');
    }
  }

  Future<Either<String, int>> deleteService(int id) async {
    try {
      final db = await database;
      final rowsAffected = await db.delete(
        'services',
        where: 'id = ?',
        whereArgs: [id],
      );
      return Right(rowsAffected);
    } catch (e) {
      return Left('Gagal menghapus layanan: $e');
    }
  }

  Future<Either<String, void>> clearAllServices() async {
    try {
      final db = await database;
      await db.delete('services');
      return const Right(null);
    } catch (e) {
      return Left('Gagal mengosongkan data: $e');
    }
  }
}
