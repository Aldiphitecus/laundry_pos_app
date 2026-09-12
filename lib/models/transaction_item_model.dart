class TransactionItemModel {
  final int? id;
  final String transactionId;
  final int serviceId;
  final String serviceName;
  final double qty;
  final String unit;
  final int price;
  final int total;

  TransactionItemModel({
    this.id,
    required this.transactionId,
    required this.serviceId,
    required this.serviceName,
    required this.qty,
    required this.unit,
    required this.price,
    required this.total,
  });

  Map<String, dynamic> toMap() {
    return {
      if (id == null) 'id': id,
      'transaction_id': transactionId,
      'service_id': serviceId,
      'service_name': serviceName,
      'qty': qty,
      'unit': unit,
      'price': price,
      'total': total,
    };
  }

  factory TransactionItemModel.fromMap(Map<String, dynamic> map) {
    return TransactionItemModel(
      id: map['id'] as int?,
      transactionId: map['transaction_id'] as String,
      serviceId: map['service_id'] as int,
      serviceName: map['service_name'] as String,
      qty: (map['qty'] as num).toDouble(),
      unit: map['unit'] as String,
      price: map['price'] as int,
      total: map['total'] as int,
    );
  }
}
