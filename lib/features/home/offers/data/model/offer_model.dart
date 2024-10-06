class OfferModel {
  final int id;
  final int companyId;
  final String name;
  final String? image;

  OfferModel({
    required this.id,
    required this.companyId,
    required this.name,
    required this.image,
  });

  // Empty
  factory OfferModel.empty() {
    return OfferModel(
      id: 0,
      companyId: 0,
      name: '',
      image: '',
    );
  }

  factory OfferModel.fromJson(Map<String, dynamic> json) {
    return OfferModel(
      id: json['id'],
      companyId: json['company_id'],
      name: json['name'] ?? '',
      image: json['image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'company_id': companyId,
      'name': name,
      'image': image,
    };
  }

  @override
  List<OfferModel> fromJsonList(List json) {
    return json.map((e) => OfferModel.fromJson(e)).toList();
  }
}
