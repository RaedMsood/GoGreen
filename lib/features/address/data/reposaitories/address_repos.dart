import 'package:gogreen/core/network/errors/error.model.wings.dart';
import 'package:gogreen/core/network/remote.wings.dart';
import 'package:gogreen/features/address/data/models/address_model.dart';
import 'package:gogreen/features/address/data/models/city_model.dart';
import 'package:gogreen/features/address/data/models/district_model.dart';
import 'package:gogreen/features/address/data/models/states_model.dart';

class AddressesRepository {
  Future<DataState<List<AddressModel>>> getAddresses() async {
    return await WingsRemoteService().send(
      request: WingsRequest(
        url: AppURL.addresses,
      ),
      method: WingsRemoteMethod.get,
      onSuccess: (response, code) {
        var addresses = AddressModel.fromJsonList(
          response.data,
        );
        return DataSuccess(addresses);
      },
      onError: (response, code) {
        return DataError<List<AddressModel>>(
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

  Future<DataState<bool>> addOrUpdateAddress(
      {int? id,
        required String address,
        required String lat,
        required String lng,
        required int stateId,

        required int cityId,
        required int districtId}) async {
    var url = AppURL.createAddress;
    var _id;
    if (id != null && id != 0) {
      url = AppURL.updateAddress;
      _id = id;
    }
    return await WingsRemoteService().send(
      request: WingsRequest(
        url: url,
        body: {
          'address': address,
          'lat': lat,
          'lng': lng,
          'state_id': stateId,
          'city_id': cityId,
          'district_id': districtId,
          'is_default': 0,
        },
        id: _id,
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

  Future<DataState<bool>> deleteAddress(int id) async {
    return await WingsRemoteService().send(
      request: WingsRequest(
        url: AppURL.deleteAddress,
        id: id,
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
  Future<DataState<List<StatesModel>>> getStates() async {
    return await WingsRemoteService().send(
      request: WingsRequest(
        url: AppURL.getStates,
      ),
      method: WingsRemoteMethod.get,
      onSuccess: (response, code) {
        var utils = StatesModel.fromJsonList(
          response.data,
        );
        return DataSuccess(utils);
      },
      onError: (response, code) {
        return DataError<List<StatesModel>>(
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
  Future<DataState<List<CityModel>>> getCities() async {
    return await WingsRemoteService().send(
      request: WingsRequest(
        url: AppURL.getCities,
      ),
      method: WingsRemoteMethod.get,
      onSuccess: (response, code) {
        var utils = CityModel.fromJsonList(
          response.data,
        );
        return DataSuccess(utils);
      },
      onError: (response, code) {
        return DataError<List<CityModel>>(
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

  Future<DataState<List<DistrictModel>>> getDistricts() async {
    return await WingsRemoteService().send(
      request: WingsRequest(
        url: AppURL.getDistricts,
      ),
      method: WingsRemoteMethod.get,
      onSuccess: (response, code) {
        var utils = DistrictModel.fromJsonList(
          response.data,
        );
        return DataSuccess(utils);
      },
      onError: (response, code) {
        return DataError<List<DistrictModel>>(
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