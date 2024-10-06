import 'package:gogreen/core/network/errors/error.model.wings.dart';
import 'package:gogreen/core/network/remote.wings.dart';
import 'package:gogreen/core/states/paginationData/pagination.model.dart';
import 'package:gogreen/features/home/notifications/data/model/model.dart';

class NotificationsRepository {
  Future<DataState<PaginationModel<NotificationModel>>> getNotifications(
      {required int page, int limit = 20}) async {
    return await WingsRemoteService().send(
      request: WingsRequest(
        url: AppURL.notifications,
        queryString: {
          'page': page,
          'perPage': limit,
        },
      ),
      method: WingsRemoteMethod.get,
      onSuccess: (response, code) {
        return DataSuccess(
          PaginationModel<NotificationModel>.fromJson(response.data, (comp) {
            return NotificationModel.fromJson(comp);
          }),
        );
      },
      onError: (response, code) {
        return DataError<PaginationModel<NotificationModel>>(
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

  Future<DataState<bool>> updateFcmToken({
    required String fcmToken,
  }) async {
    return await WingsRemoteService().send(
      request: WingsRequest(
        url: AppURL.addFcmToken,
        body: {'fcmToken': fcmToken},
      ),
      method: WingsRemoteMethod.post,
      onSuccess: (response, code) {},
      onError: (response, code) {},
    );
  }
}
