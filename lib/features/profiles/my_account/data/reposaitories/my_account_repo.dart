import 'package:gogreen/core/network/errors/error.model.wings.dart';
import 'package:gogreen/core/network/remote.wings.dart';
import 'package:gogreen/features/profiles/my_account/data/model/my_account_model.dart';

import 'package:gogreen/features/user/data/model/user.model.dart';

class MyAccountRepository {
  Future<DataState<MyAccountModel>> getProfile() async {
    return await WingsRemoteService().send(
      request: WingsRequest(
        url: AppURL.profile,
      ),
      method: WingsRemoteMethod.get,
      onSuccess: (response, code) {
        return DataSuccess<MyAccountModel>(
          MyAccountModel.fromJson(response.data),
        );
      },
      onError: (response, code) {
        return DataError<MyAccountModel>(
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

  Future<DataState<UserModel>> updateProfile({
    required String name,
    required String phone,
    required String email,
    required String storeName,
    required String commercialNumber,
    required String storeAddress,
    required String lat,
    required String lng,
  }) async {
    var data = {
      "name": name,
      'email': email,
      "phone_number": phone,
      "commercial_number": commercialNumber,
      "store_name": storeName,
      "store_address": storeAddress,
      "lat": lat,
      "lng": lng,
    };

    return await WingsRemoteService().send(
      request: WingsRequest(
        url: AppURL.updateProfile,
        body: data,
      ),
      method: WingsRemoteMethod.post,
      onSuccess: (response, code) {
        return DataSuccess<UserModel>(
          UserModel.fromJson(response.data),
        );
      },
      onError: (response, code) {
        return DataError<UserModel>(
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

  Future<DataState<bool>> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    return await WingsRemoteService().send(
      request: WingsRequest(
        url: AppURL.updatePassword,
        body: {
          "old_password": oldPassword,
          "password": newPassword,
          "password_confirmation": confirmPassword,
        },
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
