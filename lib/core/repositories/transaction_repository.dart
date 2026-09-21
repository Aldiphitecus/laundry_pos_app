import 'package:dartz/dartz.dart';
import 'package:laundry_pos_app/core/services/database_service.dart';
import 'package:laundry_pos_app/models/transaction_model.dart';

class TransactionRepository {
  final DatabaseHelpers _databaseHelpers = DatabaseHelpers.instance;

  Future<Either<String, String>> insertTransaction(
    TransactionModel transaction,
  ) async {
    try {
      final db = await _databaseHelpers.database;
      await db.transaction((txn) async {
        await txn.insert('transactions', transaction.toMap());
        for (final item in transaction.items) {
          await txn.insert('transaction_items', item.toMap());
        }
      });
      return Right(transaction.id);
    } catch (e) {
      return Left('Gagal menyimpan transaksi: $e');
    }
  }
}
