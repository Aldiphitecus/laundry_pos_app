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
}

class TransactionItemModel {
  final String serviceId;
  final String serviceName;
  final double qty;
  final String unit;
  final int price;
  final int total;

  const TransactionItemModel({
    required this.serviceId,
    required this.serviceName,
    required this.qty,
    required this.unit,
    required this.price,
    required this.total,
  });
}
