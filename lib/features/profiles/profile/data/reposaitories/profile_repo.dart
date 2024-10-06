import 'package:gogreen/core/network/errors/error.model.wings.dart';
import 'package:gogreen/core/network/remote.wings.dart';
import 'package:gogreen/features/profiles/profile/data/data_sourse/companies_favorite_hive_local.dart';
import 'package:gogreen/features/profiles/profile/data/model/app_Info_model.dart';
import 'package:gogreen/features/profiles/profile/data/model/companies_favorites_model.dart';
import 'package:gogreen/features/profiles/profile/data/model/statistic_model.dart';

class ProfileRepository {
  Future<DataState<StatisticModel>> getStatistics() async {
    return await WingsRemoteService().send(
      request: WingsRequest(
        url: AppURL.statics,
      ),
      method: WingsRemoteMethod.get,
      onSuccess: (response, code) {
        print(response.data);
        return DataSuccess(
          StatisticModel.fromJson(response.data),
        );
      },
      onError: (response, code) {
        return DataError<StatisticModel>(
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

  Future<void> addToFavourites(CompaniesFavoritesModel companyFavorite) async {
    try {
      await CompaniesFavoriteHiveLocal().add(companyFavorite);
    } catch (e) {
      throw '$e';
    }
  }

  Future<void> removeFromFavourites(int id) async {
    try {
      await CompaniesFavoriteHiveLocal().remove(id);
    } catch (e) {
      throw '$e';
    }
  }

  Future<List<CompaniesFavoritesModel>> getAllFavourites() async {
    try {
      return await CompaniesFavoriteHiveLocal().all;
    } catch (e) {
      throw '$e';
    }
  }

  Future<DataState<AppInfoModel>> getAppInfo() async {
    return await WingsRemoteService().send(
      request: WingsRequest(
        url: AppURL.appInfo,
      ),
      method: WingsRemoteMethod.get,
      onSuccess: (response, code) {
        return DataSuccess(
          AppInfoModel.fromJson(response.data),
        );
      },
      onError: (response, code) {
        return DataError<AppInfoModel>(
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

  Future<DataState<bool>> logout({
    required var fcmToken,
  }) async {
    return await WingsRemoteService().send(
      request: WingsRequest(
        url: AppURL.removeFcmToken,
        body: {'fcmToken': fcmToken},
      ),
      method: WingsRemoteMethod.post,
      onSuccess: (response, code) {
        return DataSuccess<bool>(
          true,
        );
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
