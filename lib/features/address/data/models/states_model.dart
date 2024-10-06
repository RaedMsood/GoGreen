class StatesModel {
  final int id;
  final String name;

  StatesModel({
    required this.id,
    required this.name,
  });

  factory StatesModel.fromJson(Map<String, dynamic> json) {
    return StatesModel(
      id: (json['id'] as num).toInt(),
      name: json['name']  ?? '',
    );
  }

  static List<StatesModel> fromJsonList(List<dynamic> json) {
    return json.map((e) => StatesModel.fromJson(e)).toList();
  }

  static StatesModel empty() {
    return StatesModel(id: 0, name: '');
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
