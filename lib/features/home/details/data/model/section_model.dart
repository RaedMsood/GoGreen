class SectionModel {
  final int id;
  final String name;

  SectionModel({required this.id, required this.name});

  factory SectionModel.fromJson(Map<String, dynamic> json) {
    return SectionModel(
      id: json['id'] as int,
      name: json['name'] ??"",
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory SectionModel.empty() => SectionModel(
        id: 0,
        name: '',
      );

  List<SectionModel> fromJsonList(List<dynamic> json) {
    return json
        .map((e) => SectionModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
