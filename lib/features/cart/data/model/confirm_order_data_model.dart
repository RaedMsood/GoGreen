import 'package:gogreen/features/address/data/models/city_model.dart';
import 'package:gogreen/features/address/data/models/district_model.dart';
import 'package:gogreen/features/address/data/models/states_model.dart';

class ConfirmOrderDataModel {
  final List<ConfirmOrderAddressDataModel> userAddresses;
  final List<ConfirmOrderPaymentDataModel> paymentMethods;
  final List<ConfirmOrderVehicleDataModel> vehicleTypes;

  ConfirmOrderDataModel({
    required this.userAddresses,
    required this.paymentMethods,
    required this.vehicleTypes,
  });

  factory ConfirmOrderDataModel.fromJson(Map<String, dynamic> json) {
    return ConfirmOrderDataModel(
      userAddresses: (json['user_addresses'] as List<dynamic>)
          .map((e) =>
              ConfirmOrderAddressDataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      paymentMethods: (json['payment_methods'] as List<dynamic>)
          .map((e) =>
              ConfirmOrderPaymentDataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      vehicleTypes: (json['vehicle_types'] as List<dynamic>)
          .map((e) =>
              ConfirmOrderVehicleDataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'payment_methods': paymentMethods,
      'user_addresses': userAddresses,
      'vehicle_types': vehicleTypes,
    };
  }

  static ConfirmOrderDataModel empty() {
    return ConfirmOrderDataModel(
      userAddresses: [],
      paymentMethods: [],
      vehicleTypes: [],
    );
  }
}

//////////////// Confirm Order Address Data Model //////////////////////////////////////////////////
class ConfirmOrderAddressDataModel {
  final int id;
  final String address;
  final int? isDefault;
  final StatesModel? states;

  final CityModel? city;
  final DistrictModel? district;

  ConfirmOrderAddressDataModel({
    required this.id,
    required this.address,
    this.isDefault,
    this.states,
    this.city,
    this.district,
  });

  factory ConfirmOrderAddressDataModel.fromJson(Map<String, dynamic> json) {
    return ConfirmOrderAddressDataModel(
      id: (json['id'] as num).toInt(),
      address: json['address'] as String,
      states: json['state'] == null
          ? null
          : StatesModel.fromJson(json['state'] as Map<String, dynamic>),
      city: json['city'] == null
          ? null
          : CityModel.fromJson(json['city'] as Map<String, dynamic>),
      district: json['district'] == null
          ? null
          : DistrictModel.fromJson(json['district'] as Map<String, dynamic>),
      isDefault: (json['is_default'] as num).toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'address': address,
      'is_default': isDefault,
    };
  }

  static ConfirmOrderAddressDataModel empty() {
    return ConfirmOrderAddressDataModel(
      id: 0,
      address: "",
      isDefault: 0,
    );
  }
}

//////////////// Confirm Order Payment Data Model //////////////////////////////////////////////////
class ConfirmOrderPaymentDataModel {
  final int id;
  final String name;
  final String? accountNumber;
  final String? image;

  ConfirmOrderPaymentDataModel({
    required this.id,
    required this.name,
    this.accountNumber,
    this.image,
  });

  factory ConfirmOrderPaymentDataModel.fromJson(Map<String, dynamic> json) {
    return ConfirmOrderPaymentDataModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      accountNumber: json['account_number'] as String?,
      image: json['image'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'account_number': accountNumber,
      'image': image,
    };
  }

  static ConfirmOrderPaymentDataModel empty() {
    return ConfirmOrderPaymentDataModel(
      id: 0,
      name: '',
      accountNumber: '',
      image: '',
    );
  }
}

//////////////// Confirm Order Vehicle Data Model //////////////////////////////////////////////////
class ConfirmOrderVehicleDataModel {
  final int id;
  final String name;
  final String? image;

  ConfirmOrderVehicleDataModel({
    required this.id,
    required this.name,
    this.image,
  });

  factory ConfirmOrderVehicleDataModel.fromJson(Map<String, dynamic> json) {
    return ConfirmOrderVehicleDataModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      image: json['image'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
    };
  }

  static ConfirmOrderVehicleDataModel empty() {
    return ConfirmOrderVehicleDataModel(
      id: 0,
      name: "",
      image: "",
    );
  }
}
