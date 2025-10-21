class CommentModel {
  final int id;
  final dynamic companyId;
  final dynamic reviewValue;
  final String comment;
  final String createdAt;
  final int userId;
  final String userName;
  final int commentLikeCount;
  final List<LikeStatusModel> likeStatus;

  CommentModel({
    required this.id,
    required this.companyId,
    required this.reviewValue,
    required this.comment,
    required this.createdAt,
    required this.userId,
    required this.userName,
    required this.commentLikeCount,
    required this.likeStatus,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'] ?? 0,
      companyId: json['company_id'] ?? '',
      reviewValue: json['review_value'] ?? 0.0,
      comment: json['comment'] ?? '',
      createdAt: json['created_at'] ?? '',
      userId: json['user_id'] ?? 0,
      userName: json['user_name'] ?? '',
      commentLikeCount: json['comment_like_count'] ?? 0,
      likeStatus: List<LikeStatusModel>.from(
        (json['like_status'] ?? List<LikeStatusModel>.empty).map(
          (e) => LikeStatusModel.fromJson(e),
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'company_id': companyId,
      'review_value': reviewValue,
      'comment': comment,
      'created_at': createdAt,
      'user_id': userId,
      'user_name': userName,
      'comment_like_count': commentLikeCount,
    };
  }
}

class LikeStatusModel {
  final int id;
  final int userId;
  final int commentId;
  final int status;

  LikeStatusModel({
    required this.id,
    required this.userId,
    required this.commentId,
    required this.status,
  });

  factory LikeStatusModel.fromJson(Map<String, dynamic> json) {
    return LikeStatusModel(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      commentId: json['comment_id'] ?? 0.0,
      status: json['status'] ?? 0,
    );
  }
  factory LikeStatusModel.empty() => LikeStatusModel(
    id: 0,
    userId: 0,
    commentId: 0,
    status: 0,
  );
}
