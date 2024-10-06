class OrderCompanyModel {
  final int id;
  final String name;
  final String? image;

  OrderCompanyModel({
    required this.id,
    required this.name,
    this.image,
  });

  factory OrderCompanyModel.fromJson(Map<String, dynamic> json) {
    return OrderCompanyModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      image: json['image'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
    };
  }
}
