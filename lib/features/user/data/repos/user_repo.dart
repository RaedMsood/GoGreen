import 'package:gogreen/core/network/errors/error.model.wings.dart';
import 'package:gogreen/core/network/remote.wings.dart';
import 'package:gogreen/features/user/data/model/auth.model.dart';

class UserRepository {
  Future<DataState<AuthModel>> login(
      {required String email, required String password}) async {
    return await WingsRemoteService().send(
      request: WingsRequest(
        url: AppURL.login,
        body: {
          "email": email,
          "password": password,
        },
      ),
      method: WingsRemoteMethod.post,
      onSuccess: (response, code) {
        return DataSuccess<AuthModel>(
          AuthModel.fromJson(response.data),
        );
      },
      onError: (response, code) {
        return DataError<AuthModel>(
          message: response.message,
          code: response.code,
          error: ErrorModel.fromCode(
            response.code,
            response.statusCode,
            message: response.message,
            desc: response.data,
          ),
        );
      },
    );
  }

  Future<DataState<bool>> forgetPassword({required String email}) async {
    return await WingsRemoteService().send(
      request: WingsRequest(
        url: AppURL.forgetPassword,
        body: {
          "email": email,
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

  Future<DataState<bool>> resetPassword(
      {required String email,
      required String password,
      required String confirmPassword}) async {
    return await WingsRemoteService().send(
      request: WingsRequest(
        url: AppURL.resetPassword,
        body: {
          "email": email,
          "password": password,
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

  Future<DataState<AuthModel>> register({
    required String name,
    required String phone,
    String? email,
    required String password,
    required String confirmPassword,
    required String storeName,
    required String commercialNumber,
    required String storeAddress,
    required String lat,
    required String lng,
  }) async {
    return await WingsRemoteService().send(
      request: WingsRequest(
        url: AppURL.register,
        body: {
          "name": name,
          'email': email,
          "phone_number": phone,
          "commercial_number": commercialNumber,
          "password": password,
          "password_confirmation": confirmPassword,
          "store_name": storeName,
          "store_address": storeAddress,
          "lat": lat,
          "lng": lng,
        },
      ),
      method: WingsRemoteMethod.post,
      onSuccess: (response, code) {
        return DataSuccess<AuthModel>(
          AuthModel.fromJson(response.data),
        );
      },
      onError: (response, code) {
        return DataError<AuthModel>(
          message: response.message,
          code: response.code,
          error: ErrorModel.fromCode(
            response.code,
            response.statusCode,
            message: response.message,
            desc: response.data,
          ),
        );
      },
    );
  }

  Future<DataState<bool>> sendOTP({
    required String email,
  }) async {
    return await WingsRemoteService().send(
      request: WingsRequest(
        url: AppURL.sendOtp,
        body: {
          "email": email,
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
            message: response.message,
            desc: response.data,
          ),
        );
      },
    );
  }

  Future<DataState<bool>> checkOtp({
    required String email,
    required String otp,
  }) async {
    return await WingsRemoteService().send(
      request: WingsRequest(
        url: AppURL.checkOtp,
        body: {
          "email": email,
          "otp": otp,
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

  Future<DataState<bool>> resendOtp({required String email}) async {
    return await WingsRemoteService().send(
      request: WingsRequest(
        url: AppURL.resendOtp,
        body: {
          "email": email,
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
