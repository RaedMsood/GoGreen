class MyAccountModel {
  final String name;
  final String? email;
  final String phoneNumber;
  final String storeName;
  final String storeAddress;
  final String? commercialNumber;
  final String? lat;
  final String? lng;
  final String? profileImage;

  MyAccountModel({
    required this.name,
    this.email,
    required this.phoneNumber,
    required this.storeName,
    required this.storeAddress,
    this.commercialNumber,
    this.lat,
    this.lng,
    this.profileImage,
  });

  factory MyAccountModel.fromJson(Map<String, dynamic> json) {
    return MyAccountModel(
      name: json['name'] as String,
      email: json['email'] as String?,
      phoneNumber: json['phone_number'] as String,
      storeName: json['store_name'] as String,
      storeAddress: json['store_address'] as String,
      commercialNumber: json['commercial_number'] as String?,
      lat: json['lat'] as String?,
      lng: json['lng'] as String?,
      profileImage: json['profile_image'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone_number': phoneNumber,
      'store_name': storeName,
      'store_address': storeAddress,
      'commercial_number': commercialNumber,
      'lat': lat,
      'lng': lng,
      'profile_image': profileImage,
    };
  }

  factory MyAccountModel.empty() => MyAccountModel(
        name: '',
        email: '',
        phoneNumber: '',
        storeName: '',
        storeAddress: '',
        lat: '',
        lng: '',
        profileImage: '',
        commercialNumber: '',
      );
}
