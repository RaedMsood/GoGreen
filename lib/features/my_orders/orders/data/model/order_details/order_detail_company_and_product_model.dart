class OrderDetailCompanyModel {
  final int id;
  final String name;
  final String? image;
  final dynamic rates;
  final String? address;

  OrderDetailCompanyModel({
    required this.id,
    required this.name,
    required this.rates,
    this.image,
    this.address,
  });

  factory OrderDetailCompanyModel.fromJson(Map<String, dynamic> json) {
    return OrderDetailCompanyModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      image: json['image'] as String?,
      rates: json['rates'] ?? 0.0,
      address: json['address'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'rates': rates,
      'address': address,
    };
  }

  factory OrderDetailCompanyModel.empty() => OrderDetailCompanyModel(
        id: 0,
        name: '',
        image: '',
        rates: 0.0,
        address: '',
      );
}

/// Order Detail Product Model ///////////////////////////////////////////////
class OrderDetailProductModel {
  final int id;
  final String name;
  final String? image;
  final String unit;
  final int quantity;
  final int total;

  OrderDetailProductModel({
    required this.id,
    required this.name,
    this.image,
    required this.unit,
    required this.quantity,
    required this.total,
  });

  factory OrderDetailProductModel.fromJson(Map<String, dynamic> json) {
    return OrderDetailProductModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] ?? "",
      image: json['image'] ?? '',
      unit: json['unit'] ?? "",
      quantity: (json['quantity'] as num).toInt(),
      total: (json['total'] as num).toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'unit': unit,
      'quantity': quantity,
      'total': total,
    };
  }
}
