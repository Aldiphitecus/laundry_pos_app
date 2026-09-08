import 'package:dartz/dartz.dart';
import 'package:laundry_pos_app/core/services/database_service.dart';
import 'package:laundry_pos_app/models/service_model.dart';

class ServiceRepository {
  final DatabaseHelpers _databaseHelpers = DatabaseHelpers.instance;

  Future<Either<String, int>> insertService(ServiceModel service) async {
    try {
      final db = await _databaseHelpers.database;
      final id = await db.insert('services', service.toMap());
      return Right(id);
    } catch (e) {
      return Left('Gagal menyimpan layanan: $e');
    }
  }

  Future<Either<String, List<ServiceModel>>> getAllServices() async {
    try {
      final db = await _databaseHelpers.database;
      final result = await db.query('services');
      final services = result.map((map) => ServiceModel.fromMap(map)).toList();
      return Right(services);
    } catch (e) {
      return Left('Gagal mengambil data layanan: $e');
    }
  }

  Future<Either<String, int>> updateService(ServiceModel service) async {
    try {
      final db = await _databaseHelpers.database;
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
      final db = await _databaseHelpers.database;
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
      final db = await _databaseHelpers.database;
      await db.delete('services');
      return const Right(null);
    } catch (e) {
      return Left('Gagal mengosongkan data: $e');
    }
  }
}
