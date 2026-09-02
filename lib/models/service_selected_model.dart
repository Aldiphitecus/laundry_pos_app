class ServiceSelectedModel {
  final int? id;
  final String name;
  final int price;
  final String unit;
  final double qty;

  const ServiceSelectedModel({
    this.id,
    required this.name,
    required this.price,
    required this.unit,
    required this.qty,
  });

  int get total => (qty * price).round();

  factory ServiceSelectedModel.fromMap(Map<String, dynamic> map) {
    return ServiceSelectedModel(
      id: map['id'],
      name: map['name'],
      price: map['price'],
      unit: map['unit'],
      qty: (map['qty'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'price': price, 'unit': unit, 'qty': qty};
  }

  ServiceSelectedModel copyWith({
    int? id,
    String? name,
    int? price,
    String? unit,
    double? qty,
  }) {
    return ServiceSelectedModel(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      unit: unit ?? this.unit,
      qty: qty ?? this.qty,
    );
  }
}
