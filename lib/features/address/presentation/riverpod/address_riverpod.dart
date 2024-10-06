import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gogreen/core/helpers/flash_bar_helper.dart';
import 'package:gogreen/core/states/data.state.dart';
import 'package:gogreen/core/states/generateData.state.dart';
import 'package:gogreen/features/address/data/models/address_model.dart';
import 'package:gogreen/features/address/data/models/city_model.dart';
import 'package:gogreen/features/address/data/models/district_model.dart';
import 'package:gogreen/features/address/data/models/states_model.dart';
import 'package:gogreen/features/address/data/reposaitories/address_repos.dart';
import 'package:gogreen/features/address/presentation/riverpod/map_state.dart';
import 'package:gogreen/features/address/presentation/widget/address_store_form.dart';
import 'package:gogreen/locator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// Map Riverpod ////////////////////////////////////////////////////////////////////////////////////////
final mapProvider = StateNotifierProvider.autoDispose<MapNotifier, MapState>(
    (ref) => MapNotifier());

class MapNotifier extends StateNotifier<MapState> {
  MapNotifier() : super(MapState.initial());

  final _streamController = StreamController<LatLng>();

  Stream<LatLng> get locationStream => _streamController.stream;

  bool locationIsEmpty = true;
  bool checkForLocationChanges = false;

  void changeLocation(LatLng latLng) {
    state = state.copyWith(
      temp: latLng,
    );
  }

  void confirmLocation() {
    _streamController.add(state.temp);
    state = state.copyWith(
      location: state.temp,
    );
  }
}

/// Get All Addresses Riverpod //////////////////////////////////////////////////////////////////////////////
final getAllAddressesProvider = StateNotifierProvider.autoDispose<
    GetAllAddressesController, GenerateDataState<List<AddressModel>>>(
  (ref) {
    return GetAllAddressesController();
  },
);

class GetAllAddressesController
    extends StateNotifier<GenerateDataState<List<AddressModel>>> {
  GetAllAddressesController()
      : super(GenerateDataState<List<AddressModel>>.initial([])) {
    getData();
  }

  final _controller = locator<AddressesRepository>();

  Future<void> getData() async {
    state = state.loading();
    final data = await _controller.getAddresses();
    if (data is DataSuccess) {
      state = state.success(data.data as List<AddressModel>);
    } else {
      state = state.failure(data.message, error: data.error);
    }
  }
}

/// Address Store Riverpod ////////////////////////////////////////////////////////////////////////////////////////
final addressStoreProvider = StateNotifierProvider.autoDispose
    .family<AddressStoreController, GenerateDataState<bool>, AddressModel>(
  (ref, address) {
    return AddressStoreController(address);
  },
);

class AddressStoreController extends StateNotifier<GenerateDataState<bool>> {
  AddressStoreController(this.address)
      : super(GenerateDataState<bool>.initial(false)) {
    fillForm(address);
  }

  final AddressModel address;

  final _controller = locator<AddressesRepository>();
  final AddressStoreFormController form =
      AddressStoreFormController(AddressModel.empty());

  fillForm(AddressModel address) {
    form.fillForm(address);
  }

  Future<void> addOrUpdateAddress({
    required BuildContext context,
    required Function onSuccess,
    required double lat,
    required double lng,
  }) async {
    form.group.markAllAsTouched();
    if (!form.group.valid) return;
    state = state.loading();

    var formData = form.group.value;

    final data = await _controller.addOrUpdateAddress(
      id: address.id,
      stateId: formData['state_id'] as int,
      cityId: formData['city_id'] as int,
      districtId: formData['district_id'] as int,
      address: formData['address'].toString(),
      lat: lat.toString(),
      lng: lng.toString(),
    );
    if (data is DataSuccess) {
      onSuccess();
      state = state.success(true);
    } else {
      showFlashBarError(
        context: context,
        message: "${data.message} ${data.error!.desc.toString()}",
      );
      state = state.failure(data.message, error: data.error);
    }
  }

  void deleteAddress(
    BuildContext context, {
    required Function onSuccess,
  }) async{
    state = state.loading();
    final data = await _controller.deleteAddress(address.id);
    if (data is DataSuccess) {
      state = state.success(true);
      onSuccess();
    } else {
      showFlashBarError(
        context: context,
        message: "${data.message} ${data.error!.desc.toString()}",
      );
      state = state.failure(data.message, error: data.error);
    }



  }


}

/// States Riverpod ////////////////////////////////////////////////////////////////////////////////////////
final statesProvider = StateNotifierProvider.autoDispose<StatesController,
    GenerateDataState<List<StatesModel>>>(
  (ref) {
    return StatesController();
  },
);

class StatesController
    extends StateNotifier<GenerateDataState<List<StatesModel>>> {
  StatesController() : super(GenerateDataState<List<StatesModel>>.initial([])) {
    getData();
  }

  final _controller = locator<AddressesRepository>();

  Future<void> getData() async {
    state = state.loading();

    final data = await _controller.getStates();
    if (data is DataSuccess) {
      state = state.success(data.data as List<StatesModel>);
    } else {
      state = state.failure(data.message, error: data.error);
    }
  }

}

/// Cities Riverpod ////////////////////////////////////////////////////////////////////////////////////////
final citiesProvider =
    StateNotifierProvider.autoDispose<CitiesController, GenerateDataState<List<CityModel>>>(
  (ref) {
    return CitiesController();
  },
);

class CitiesController
    extends StateNotifier<GenerateDataState<List<CityModel>>> {
  CitiesController() : super(GenerateDataState<List<CityModel>>.initial([])) {
    getData();
  }

  final _controller = locator<AddressesRepository>();

  Future<void> getData() async {
    state = state.loading();

    final data = await _controller.getCities();
    if (data is DataSuccess) {
      state = state.success(data.data as List<CityModel>);
    } else {
      state = state.failure(data.message, error: data.error);
    }
  }
}

/// Districts Riverpod ////////////////////////////////////////////////////////////////////////////////////////
final districtsProvider = StateNotifierProvider.autoDispose<DistrictsController,
    GenerateDataState<List<DistrictModel>>>(
  (ref) {
    return DistrictsController();
  },
);

class DistrictsController
    extends StateNotifier<GenerateDataState<List<DistrictModel>>> {
  DistrictsController()
      : super(GenerateDataState<List<DistrictModel>>.initial([])) {
    getData();
  }

  final _controller = locator<AddressesRepository>();

  Future<void> getData() async {
    state = state.loading();

    final data = await _controller.getDistricts();
    if (data is DataSuccess) {
      state = state.success(data.data!);
    } else {
      state = state.failure(data.message, error: data.error);
    }
  }
}
