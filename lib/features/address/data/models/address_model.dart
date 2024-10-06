import 'city_model.dart';
import 'district_model.dart';
import 'states_model.dart';

class AddressModel {
  final int id;
  final String address;
  final String lat;
  final String lon;
  final int? cityId;
  final int? districtId;
  final int? stateId;
  final StatesModel? states;
  final CityModel? city;
  final DistrictModel? district;
  final bool? isDefault;

  AddressModel({
    required this.id,
    required this.address,
    required this.lat,
    required this.lon,
    this.cityId,
    this.districtId,
    this.stateId,
    this.states,
    this.district,
    this.city,
    this.isDefault,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: (json['id'] as num).toInt(),
      address: json['address'] ??"",
      stateId: (json['state_id'] as num?)?.toInt(),
      cityId: (json['city_id'] as num?)?.toInt(),
      districtId: (json['district_id'] as num?)?.toInt(),
      lat: json['lat'] ??"",
      lon: json['lng'] ??"",
      states: json['state'] == null
          ? null
          : StatesModel.fromJson(json['state'] as Map<String, dynamic>),
      city: json['city'] == null
          ? null
          : CityModel.fromJson(json['city'] as Map<String, dynamic>),
      district: json['district'] == null
          ? null
          : DistrictModel.fromJson(json['district'] as Map<String, dynamic>),
      isDefault: json['isDefault'] as bool? ?? false,
    );
  }

  static List<AddressModel> fromJsonList(List<dynamic> json) {
    return json.map((e) => AddressModel.fromJson(e)).toList();
  }

  static AddressModel empty() {
    return AddressModel(
      id: 0,
      address: '',
      stateId: 0,
      cityId: 0,
      districtId: 0,
      lat: '',
      lon: '',
      states: StatesModel.empty(),
      city: CityModel.empty(),
      district: DistrictModel.empty(),
      isDefault: false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'address': address,
      'state_id': stateId,
      'city_id': cityId,
      'district_id': districtId,
      'lat': lat,
      'lng': lon,
      'state': states,
      'city': city,
      'district': district,
      'isDefault': isDefault,
    };
  }
}
