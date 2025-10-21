class OrderDetailUserModel {
  final String name;
  final String address;

  OrderDetailUserModel({
    required this.name,
    required this.address,
  });

  factory OrderDetailUserModel.fromJson(Map<String, dynamic> json) {
    return OrderDetailUserModel(
      name: json['store_name'] as String,
      address: json['store_address'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'store_name': name,
      'store_address': address,
    };
  }

  factory OrderDetailUserModel.empty() => OrderDetailUserModel(
        name: '',
        address: '',
      );
}

/// Order Address Model ///////////////////////////////////
class OrderAddressModel {
  final String state;

  final String city;
  final String district;
  final String address;
  final String lat;
  final String lng;

  OrderAddressModel({
    required this.state,
    required this.city,
    required this.district,
    required this.address,
    required this.lat,
    required this.lng,
  });

  factory OrderAddressModel.fromJson(Map<String, dynamic> json) {
    return OrderAddressModel(
      state: json['state'] as String,
      city: json['city'] as String,
      district: json['district'] as String,
      address: json['address'] as String,
      lat: json['lat'] as String,
      lng: json['lng'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'state': state,
      'city': city,
      'district': district,
      'address': address,
      'lat': lat,
      'lng': lng,
    };
  }

  factory OrderAddressModel.empty() => OrderAddressModel(
        state: '',
        city: '',
        district: '',
        address: '',
        lat: '',
        lng: '',
      );
}
