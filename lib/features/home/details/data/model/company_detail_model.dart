import 'package:gogreen/features/home/main/data/model/offer_model.dart';
import 'category_model.dart';
import 'product_pagenation_model.dart';
import 'section_model.dart';

class CompanyDetailModel {
  final int? id;
  final String? name;
  final String? address;
  final String? image;
  final dynamic rates;
  final List<OfferModel> offers;
  final List<SectionModel> sections;
  final List<CategoryModel> categories;
  final PaginatedProductsListModel products;

  CompanyDetailModel({
    this.id,
    this.name,
    this.address,
    this.image,
    this.rates = 0.0,
    required this.offers,
    required this.sections,
    required this.products,
    required this.categories,
  });

  factory CompanyDetailModel.empty() => CompanyDetailModel(
        id: 0,
        name: '',
        address: '',
        image: '',
        offers: [],
        rates: 0.0,
        sections: [],
        categories: [],
        products: PaginatedProductsListModel.empty(),
      );

  factory CompanyDetailModel.fromJson(Map<String, dynamic> json) {
    return CompanyDetailModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      address: json['address'] ?? "",
      rates: json['rates'] ?? 0.0,
      image: json['image'] as String?,
      offers: (json['offers'] as List<dynamic>?)
              ?.map((e) => OfferModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      sections: (json['sections'] as List<dynamic>?)
              ?.map((e) => SectionModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      categories: (json['categories'] as List<dynamic>?)
              ?.map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      products: json['products'] == null
          ? PaginatedProductsListModel.empty()
          : PaginatedProductsListModel.fromJson(
              json['products'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'image': image,
      'offers': offers,
      'rates': rates,
      'sections': sections,
      'products': products,
      'categories': categories,
    };
  }

  CompanyDetailModel copyWith({
    int? id,
    String? name,
    String? address,
    String? image,
    List<OfferModel>? offers,
    List<SectionModel>? sections,
    List<CategoryModel>? categories,
    PaginatedProductsListModel? products,
  }) {
    return CompanyDetailModel(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      image: image ?? this.image,
      offers: offers ?? this.offers,
      sections: sections ?? this.sections,
      products: products ?? this.products,
      categories: categories ?? this.categories,
    );
  }
}
