class CityModel {
  final int id;
  final String nameEn;
  final int? stateId;

  CityModel({
    required this.id,
    required this.nameEn,
    this.stateId,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      id: (json['id'] as num).toInt(),
      nameEn: json['name_en'] ?? '',
      stateId: (json['state_id'] as num?)?.toInt() ?? 0,
    );
  }

  static List<CityModel> fromJsonList(List<dynamic> json) {
    return json.map((e) => CityModel.fromJson(e)).toList();
  }

  static CityModel empty() {
    return CityModel(id: 0, nameEn: '', stateId: 0);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name_en': nameEn,
      'state_id': stateId,
    };
  }
}
