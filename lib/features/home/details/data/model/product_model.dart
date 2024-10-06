class ProductModel {
  final int id;
  final String name;
  final String image;
  final String price;
  final String unit;
  final int sectionId;
  final int companyId;

  ProductModel({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.unit,
    required this.sectionId,
    required this.companyId,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as int,
      name: json['name'] as String,
      image: json['image'] ?? '',
      price: json['price'] as String,
      unit: json['unit'] as String,
      sectionId: json['section_id'] as int,
      companyId: json['company_id'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'price': price,
      'unit': unit,
      'section_id': sectionId,
      'company_id': companyId,
    };
  }

  factory ProductModel.empty() => ProductModel(
        id: 0,
        sectionId: 0,
        name: '',
        image: '',
        price: '0',
        unit: '',
        companyId: 0,
      );

  List<ProductModel> fromJsonList(List<dynamic> json) {
    return json
        .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
