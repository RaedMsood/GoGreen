import 'package:gogreen/core/network/errors/error.model.wings.dart';
import 'package:gogreen/core/network/remote.wings.dart';

import '../model/evaluation_model.dart';

class EvaluationRepository {
  Future<DataState<EvaluationModel>> getEvaluationAndComment({
    required int companyId,
    int page = 1,
    int limit = 5,
  }) async {
    return await WingsRemoteService().send(
      request: WingsRequest(
        url: AppURL.getCompanyReviews,
        id: companyId,
        queryString: {
          'page': page,
          'perPage': limit,
        },
      ),
      method: WingsRemoteMethod.get,
      onSuccess: (response, code) {
        print(response.data);
        return DataSuccess<EvaluationModel>(
          EvaluationModel.fromJson(
            response.data,
          ),
        );
      },
      onError: (response, code) {
        return DataError<EvaluationModel>(
          message: response.message,
          code: response.code,
          error: ErrorModel.fromCode(
            response.code,
            response.statusCode,
          ),
        );
      },
    );
  }

  Future<DataState<bool>> addEvaluationAndComment(int id,
      double rating,
      String comment,) async {
    return await WingsRemoteService().send(
      request: WingsRequest(
        url: AppURL.addReviewsAndCommentReview,
        body: {
          'order_id': id,
          'value': rating,
          'comment': comment,
        },
      ),
      method: WingsRemoteMethod.post,
      onSuccess: (response, code) {
        return DataSuccess(true);
      },
      onError: (response, code) {
        return DataError<bool>(
          message: response.message,
          code: response.code,
          error: ErrorModel.fromCode(
            response.code,
            response.statusCode,
          ),
        );
      },
    );
  }

  Future<DataState<bool>> addLike(int commentId,) async {
    return await WingsRemoteService().send(
      request: WingsRequest(
        url: "${AppURL.addLike}/$commentId",
        queryString: {
          'comment_id': commentId,
        },
      ),
      method: WingsRemoteMethod.get,
      onSuccess: (response, code) {
        return DataSuccess(true);
      },
      onError: (response, code) {
        return DataError<bool>(
          message: response.message,
          code: response.code,
          error: ErrorModel.fromCode(
            response.code,
            response.statusCode,
          ),
        );
      },
    );
  }

  Future<DataState<bool>> dislike(int commentId,) async {
    return await WingsRemoteService().send(
      request: WingsRequest(
        url: "${AppURL.dislike}/$commentId",
        queryString: {
          'comment_id': commentId,
        },
      ),
      method: WingsRemoteMethod.get,
      onSuccess: (response, code) {
        return DataSuccess(true);
      },
      onError: (response, code) {
        return DataError<bool>(
          message: response.message,
          code: response.code,
          error: ErrorModel.fromCode(
            response.code,
            response.statusCode,
          ),
        );
      },
    );
  }
}
