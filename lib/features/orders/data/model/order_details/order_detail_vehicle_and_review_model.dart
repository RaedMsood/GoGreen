class OrderDetailVehicleModel {
  final int id;
  final String name;
  final String? image;

  OrderDetailVehicleModel({
    required this.id,
    required this.name,
    required this.image,
  });

  factory OrderDetailVehicleModel.fromJson(Map<String, dynamic> json) {
    return OrderDetailVehicleModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      image: json['image'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
    };
  }

  factory OrderDetailVehicleModel.empty() => OrderDetailVehicleModel(
        id: 0,
        name: '',
        image: '',
      );
}

/// Order Review Model ////////////////////////////////////
class OrderDetailReview {
  final double reviewValue;
  final String? comment;
  final String createdAt;

  OrderDetailReview({
    required this.reviewValue,
    this.comment,
    required this.createdAt,
  });

  factory OrderDetailReview.fromJson(Map<String, dynamic> json) {
    return OrderDetailReview(
      reviewValue: (json['review_value'] as num).toDouble(),
      comment: json['comment'] ??'',
      createdAt: json['created_at'] ??'',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'review_value': reviewValue,
      'comment': comment,
      'created_at': createdAt,
    };
  }

  factory OrderDetailReview.empty() => OrderDetailReview(
        reviewValue: 0,
        comment: '',
        createdAt: '',
      );
}
