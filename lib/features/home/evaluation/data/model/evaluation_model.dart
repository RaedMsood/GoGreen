import 'evaluation_pagination_model.dart';

class EvaluationModel {
  final double rates;
  final int total;
  final List<RatingLineBarModel> ratingLineBar;
  final PaginatedEvaluationModel comment;

  EvaluationModel({
    required this.rates,
    required this.total,
    required this.ratingLineBar,
    required this.comment,
  });

  factory EvaluationModel.fromJson(Map<String, dynamic> json) {
    return EvaluationModel(
      rates: json['rates'] ?? 0.0,
      total: json['totle'] ?? 0,

       ratingLineBar: List<RatingLineBarModel>.from(
           (json['counter'] ?? List<RatingLineBarModel>.empty())
               .map((e) => RatingLineBarModel.fromJson(e))),
      comment: json['review'] == null
          ? PaginatedEvaluationModel.empty()
          : PaginatedEvaluationModel.fromJson(
              json['review'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rates': rates,
      'totle': total,
      'counter': ratingLineBar,
      'review': comment,
    };
  }

  factory EvaluationModel.empty() => EvaluationModel(
        rates: 0.0,
        total: 0,
        ratingLineBar: [],
        comment: PaginatedEvaluationModel.empty(),
      );

  EvaluationModel copyWith({
    double? rates,
    int? total,
    List<RatingLineBarModel>? ratingLineBar,
    PaginatedEvaluationModel? comment,
  }) {
    return EvaluationModel(
      rates: rates ?? this.rates,
      total: total ?? this.total,
      ratingLineBar: ratingLineBar ?? this.ratingLineBar,
      comment: comment ?? this.comment,
    );
  }
}

////////////////////////////////////////////////////////
class RatingLineBarModel {
  final int lineNumber;
  final int value;

  RatingLineBarModel({
    required this.lineNumber,
    required this.value,
  });

  factory RatingLineBarModel.fromJson(Map<String, dynamic> json) {
    return RatingLineBarModel(
      lineNumber: json['name'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': lineNumber,
      'value': value,
    };
  }

  factory RatingLineBarModel.empty() => RatingLineBarModel(
        lineNumber: 0,
        value: 0,
      );
}
