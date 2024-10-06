import 'package:gogreen/features/home/details/data/model/company_detail_model.dart';

class CompanyModel {
  final int id;
  final dynamic rates;
  final String address;
  final String name;
  final String? image;

  CompanyModel({
    required this.id,
    required this.rates,
    required this.address,
    required this.name,
    required this.image,
  });

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      id: json['id'],
      name: json['name'] ?? "",
      rates: json['rates']??0.0 ,
      address: json['address'] ?? "",
      image: json['image'] ?? "",
    );
  }

  factory CompanyModel.fromDetail(CompanyDetailModel detail) {
    return CompanyModel(
      id: detail.id ?? 0,
      rates: detail.rates ,
      address: detail.address ?? '----------',
      name: detail.name ?? '',
      image: detail.image,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_id': name,
      'image': image,
      'rates': rates,
      'name': name,
    };
  }

  factory CompanyModel.empty() {
    return CompanyModel(
      id: 0,
      rates: 0,
      address: '',
      name: '',
      image: '',
    );
  }
}
