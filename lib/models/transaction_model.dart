import 'package:laundry_pos_app/models/transaction_item_model.dart';

class TransactionModel {
  final String id;
  final String transactionNumber;
  final String customerName;
  final DateTime transactionDate;
  final int total;
  final DateTime createdAt;
  final List<TransactionItemModel> items;

  const TransactionModel({
    required this.id,
    required this.transactionNumber,
    required this.customerName,
    required this.transactionDate,
    required this.total,
    required this.createdAt,
    required this.items,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'transaction_number': transactionNumber,
      'customer_name': customerName,
      'transaction_date': transactionDate.toIso8601String(),
      'total': total,
      'create_at': createdAt.toIso8601String(),
    };
  }

  factory TransactionModel.fromMap(
    Map<String, dynamic> map, {
    List<TransactionItemModel> items = const [],
  }) {
    return TransactionModel(
      id: map['id'] as String,
      transactionNumber: map['transaction_number'] as String,
      customerName: map['customer_name'] as String,
      transactionDate: DateTime.parse(map['transaction_date'] as String),
      total: map['total'] as int,
      createdAt: DateTime.parse(map['created_at'] as String),
      items: items,
    );
  }
}
