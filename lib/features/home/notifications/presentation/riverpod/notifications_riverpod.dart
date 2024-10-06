import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gogreen/core/states/data.state.dart';
import 'package:gogreen/core/states/generateData.state.dart';
import 'package:gogreen/core/states/paginatedData.state.dart';
import 'package:gogreen/core/states/view.state.dart';
import 'package:gogreen/features/home/notifications/data/model/model.dart';
import 'package:gogreen/features/home/notifications/data/reposaitories/notifications_repo.dart';
import 'package:gogreen/features/services/auth/auth.dart';
import 'package:gogreen/locator.dart';

final notificationsProvider = StateNotifierProvider.autoDispose<
    NotificationsController, PaginatedData<NotificationModel>>(
  (ref) => NotificationsController(),
);

class NotificationsController
    extends StateNotifier<PaginatedData<NotificationModel>> {
  NotificationsController()
      : super(PaginatedData<NotificationModel>.initial(
            PaginationModel<NotificationModel>.empty())) {
    getData();
  }

  final _controller = locator<NotificationsRepository>();

  //get date from api when the page is loaded
  Future<void> getData({
    bool moreData = false,
  }) async {
    if (state.viewState == ViewState.loadingMore ||
        state.viewState == ViewState.loading) return;

    if (moreData) {
      state = state.loadingMore();
    } else {
      state = state.loading();
    }

    int page = state.data.currentPage + 1;
    final data = await _controller.getNotifications(
      page: page,
    );

    if (data is DataSuccess) {
      state = state.success(data.data!);
      if (!moreData && data.data!.data.isEmpty) {
        state = state.empty(message: 'No Notification Data');
      }
    } else {
      state = state.failure(
        data.message,
        error: data.error,
      );
    }
  }
}

final updateFcmTokenProvider = StateNotifierProvider.autoDispose<
    UpdateFcmTokenController, GenerateDataState<bool>>(
  (ref) {
    return UpdateFcmTokenController();
  },
);

class UpdateFcmTokenController extends StateNotifier<GenerateDataState<bool>> {
  UpdateFcmTokenController() : super(GenerateDataState<bool>.initial(false));
  final _controller = NotificationsRepository();

  Future<void> updateFcmToken({required String fcmToken}) async {
    // final WingsSecureStorage secureStorage = locator<WingsSecureStorage>();
    // var fcmToken = await secureStorage.read(key: 'fcmToken');
    if (Auth().loggedIn) {
      state = state.loading();

      final data = await _controller.updateFcmToken(
        fcmToken: fcmToken,
      );
      if (data is DataSuccess) {
        print("RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR");
        state = state.success(true);
      } else {
        print("OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOoo");
        state = state.failure(data.message);
      }
    }
  }
}
