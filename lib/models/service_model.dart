class ServiceModel {
  final int? id;
  final String name;
  final int price;
  final String unit;

  const ServiceModel({
    this.id,
    required this.name,
    required this.price,
    required this.unit,
  });

  factory ServiceModel.fromMap(Map<String, dynamic> map) {
    return ServiceModel(
      id: map['id'],
      name: map['name'],
      price: map['price'],
      unit: map['unit'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'price': price, 'unit': unit};
  }
}
