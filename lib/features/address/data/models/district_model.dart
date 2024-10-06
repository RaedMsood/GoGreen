class DistrictModel {
  final int id;
  final String nameEn;
  final int? cityId;

  DistrictModel({
    required this.id,
    required this.nameEn,
    this.cityId,
  });

  factory DistrictModel.fromJson(Map<String, dynamic> json) {
    return DistrictModel(
      id: (json['id'] as num).toInt(),
      nameEn: json['name_en'] ?? '',
      cityId: (json['city_id'] as num?)?.toInt() ?? 0,
    );
  }

  static List<DistrictModel> fromJsonList(List<dynamic> json) {
    return json.map((e) => DistrictModel.fromJson(e)).toList();
  }

  static DistrictModel empty() {
    return DistrictModel(id: 0, nameEn: '', cityId: 0);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name_en': nameEn,
      'city_id': cityId,
    };
  }
}
