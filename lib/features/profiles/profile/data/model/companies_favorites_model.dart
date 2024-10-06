class CompaniesFavoritesModel {
  final int id;
  final dynamic rates;
  final String address;
  final String name;
  final String? image;

  CompaniesFavoritesModel({
    required this.id,
    required this.rates,
    required this.address,
    required this.name,
    required this.image,
  });

  factory CompaniesFavoritesModel.fromJson(Map<String, dynamic> json) {
    return CompaniesFavoritesModel(
      id: json['id'],
      name: json['name'] ?? "",
      rates: json['rates'],
      address: json['address'] ?? "",
      image: json['image'] ?? "",
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
}
