
import 'product_model.dart';

class PaginatedProductsListModel {
  final List<ProductModel> data;
  final int total;
  final int currentPage;
  final int perPage;

  PaginatedProductsListModel({
    required this.data,
    required this.total,
    required this.currentPage,
    required this.perPage,
  });

  factory PaginatedProductsListModel.fromJson(Map<String, dynamic> json) {
    return PaginatedProductsListModel(
      data: (json['data'] as List<dynamic>)
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: json['total'] as int,
      currentPage: json['current_page'] as int,
      perPage: json['per_page'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((e) => e.toJson()).toList(),
      'total': total,
      'current_page': currentPage,
      'per_page': perPage,
    };
  }

  factory PaginatedProductsListModel.empty() => PaginatedProductsListModel(
        currentPage: 0,
        perPage: 0,
        total: 0,
        data: [],
      );

  // copy
  PaginatedProductsListModel copyWith({
    List<ProductModel>? data,
    int? total,
    int? currentPage,
    int? perPage,
  }) {
    return PaginatedProductsListModel(
      data: data ?? this.data,
      total: total ?? this.total,
      currentPage: currentPage ?? this.currentPage,
      perPage: perPage ?? this.perPage,
    );
  }
}
