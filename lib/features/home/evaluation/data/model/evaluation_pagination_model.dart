import 'comment_model.dart';

class PaginatedEvaluationModel {
  final List<CommentModel> data;
  final dynamic currentPage;

  PaginatedEvaluationModel({
    required this.data,
    required this.currentPage,
  });

  factory PaginatedEvaluationModel.fromJson(Map<String, dynamic> json) {
    return PaginatedEvaluationModel(
      data: (json['data'] as List<dynamic>)
          .map((e) => CommentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      currentPage: json['current_page'] ??0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((e) => e.toJson()).toList(),
      'current_page': currentPage,
    };
  }

  factory PaginatedEvaluationModel.empty() => PaginatedEvaluationModel(
        currentPage: 0,

        data: [],
      );

  PaginatedEvaluationModel copyWith({
    List<CommentModel>? data,
    int? currentPage,
  }) {
    return PaginatedEvaluationModel(
      data: data ?? this.data,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}
