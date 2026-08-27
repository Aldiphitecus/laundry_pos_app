class ServiceSelectedModel {
  final int? id;
  final String name;
  final int price;
  final String unit;
  final int qty;

  const ServiceSelectedModel({
    this.id,
    required this.name,
    required this.price,
    required this.unit,
    required this.qty,
  });

  factory ServiceSelectedModel.fromMap(Map<String, dynamic> map) {
    return ServiceSelectedModel(
      id: map['id'],
      name: map['name'],
      price: map['price'],
      unit: map['unit'],
      qty: map['qty'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'price': price, 'unit': unit, 'qty': qty};
  }
}
