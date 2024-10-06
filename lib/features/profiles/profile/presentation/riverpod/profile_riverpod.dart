import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gogreen/core/helpers/flash_bar_helper.dart';
import 'package:gogreen/core/local/secure.storage.dart';
import 'package:gogreen/core/states/data.state.dart';
import 'package:gogreen/core/states/generateData.state.dart';
import 'package:gogreen/features/profiles/profile/data/model/app_Info_model.dart';
import 'package:gogreen/features/profiles/profile/data/model/companies_favorites_model.dart';
import 'package:gogreen/features/profiles/profile/data/model/statistic_model.dart';
import 'package:gogreen/features/profiles/profile/data/reposaitories/profile_repo.dart';
import 'package:gogreen/features/services/auth/auth.dart';
import 'package:gogreen/locator.dart';

/// Statistic Riverpod /////////////////////////////////
final statisticsProvider = StateNotifierProvider.autoDispose<
    StatisticController, GenerateDataState<StatisticModel>>(
  (ref) {
    return StatisticController();
  },
);

class StatisticController
    extends StateNotifier<GenerateDataState<StatisticModel>> {
  StatisticController()
      : super(
            GenerateDataState<StatisticModel>.initial(StatisticModel.empty())) {
    getData();
  }

  final _controller = ProfileRepository();

  Future<void> getData() async {
    state = state.loading();

    final data = await _controller.getStatistics();
    if (data is DataSuccess) {
      state = state.success(data.data as StatisticModel);
    } else {
      state = state.failure(
        data.message,
        error: data.error,
      );
    }
  }
}

/// Favorite Companies Riverpod /////////////////////////////////
final favoriteCompaniesProvider = StateNotifierProvider.autoDispose<
    FavoriteCompaniesController, List<CompaniesFavoritesModel>>(
  (ref) => FavoriteCompaniesController(),
);

class FavoriteCompaniesController
    extends StateNotifier<List<CompaniesFavoritesModel>> {
  FavoriteCompaniesController() : super([]) {
    getAllFavourites();
  }

  final _controller = ProfileRepository();

  Future<void> toggleFavourite(CompaniesFavoritesModel companyFavorite) async {
    var index = state.indexWhere(
      (element) => element.id == companyFavorite.id,
    );
    if (index != -1) {
      await _controller.removeFromFavourites(companyFavorite.id);
    } else {
      await _controller.addToFavourites(companyFavorite);
      state = [...state, companyFavorite];
    }
  }

  Future<void> getAllFavourites() async {
    state = await _controller.getAllFavourites();
  }
}

final appInfoProvider = StateNotifierProvider.autoDispose<AppInfoController,
    GenerateDataState<AppInfoModel>>(
  (ref) {
    return AppInfoController();
  },
);

class AppInfoController extends StateNotifier<GenerateDataState<AppInfoModel>> {
  AppInfoController()
      : super(GenerateDataState<AppInfoModel>.initial(AppInfoModel.empty())) {
    getData();
  }

  final _controller = ProfileRepository();

  Future<void> getData() async {
    state = state.loading();

    final data = await _controller.getAppInfo();
    if (data is DataSuccess) {
      state = state.success(data.data!);
    } else {
      state = state.failure(
        data.message,
        error: data.error,
      );
    }
  }
}

final logoutProvider = StateNotifierProvider.autoDispose<LogoutController,
    GenerateDataState<bool>>(
  (ref) {
    return LogoutController();
  },
);

class LogoutController extends StateNotifier<GenerateDataState<bool>> {
  LogoutController() : super(GenerateDataState<bool>.initial(false));
  final _controller = ProfileRepository();

  Future<void> logout({
    required BuildContext context,
    required Function onSuccess,
  }) async {
    final WingsSecureStorage secureStorage = locator<WingsSecureStorage>();
    var fcmToken = await secureStorage.read(key: 'fcmToken');
    state = state.loading();

    final data = await _controller.logout(
      fcmToken: fcmToken,
    );

    if (data is DataSuccess) {
      await Auth().logout();
      onSuccess();
      state = state.success(true);
    } else {
       showFlashBarError(
        context: context,
        message: "${data.message} ${data.error!.desc.toString()}",
      );
    }
    state = state.failure(data.message, error: data.error);
  }
}
