class CategoryModel {
  final int id;
  final int sectionId;
  final String name;

  CategoryModel(
      {required this.id, required this.name, required this.sectionId});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as int,
      sectionId: json['section_id'] as int,
      name: json['name'] ?? '',
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'section_id': sectionId,
    };
  }

  factory CategoryModel.empty() => CategoryModel(
        id: 0,
        sectionId: 0,
        name: '',
      );

  @override
  List<CategoryModel> fromJsonList(List<dynamic> json) {
    return json
        .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
