import 'package:gogreen/features/home/main/data/model/company_model.dart';

class ProductDetailModel {
  final int id;
  final String name;
  final String image;
  final String description;
  final String category;
  final CompanyModel company;
  String? price;
  String? unit;
  List<String>? slider;
  int? sectionId;

  ProductDetailModel({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.category,
    required this.company,
    this.price,
    this.unit,
    this.slider,
    this.sectionId,
  });

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] ?? "",
      image: json['image'] ?? '',
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      company: CompanyModel.fromJson(json['company'] as Map<String, dynamic>),
      price: json['price'] ?? '',
      unit: json['unit'] ?? '',
      slider: (json['slider'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      sectionId: (json['sectionId'] as num?)?.toInt() ?? 0,
    );
  }

  factory ProductDetailModel.empty() => ProductDetailModel(
        id: 0,
        company: CompanyModel.empty(),
        sectionId: 0,
        name: '',
        image: '',
        description: '',
        category: '',
      );
}
