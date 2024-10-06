class UserModel {
  final int id;
  final String name;
  final String phoneNumber;
  final String email;
  final StoreAddressModel storeAddress;

  UserModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.storeAddress,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] ?? "",
      email: json['email'] ?? "",
      phoneNumber: json['phone_number'] ?? "",
      storeAddress: StoreAddressModel.fromJson(json['customer'] ?? json),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone_number': phoneNumber,
      'store_address': storeAddress.storeAddress,
    };
  }

  factory UserModel.empty() => UserModel(
        id: 0,
        name: '',
        email: '',
        phoneNumber: '',
        storeAddress: StoreAddressModel.empty(),
      );
}

class StoreAddressModel {
  final int userId;
  final String storeAddress;

  StoreAddressModel({
    required this.userId,
    required this.storeAddress,
  });

  factory StoreAddressModel.fromJson(Map<String, dynamic> json) {
    return StoreAddressModel(
      userId: json['user_id'] ?? 0,
      storeAddress: json['store_address'] ??"",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'store_address': storeAddress,
    };
  }

  factory StoreAddressModel.empty() => StoreAddressModel(
        userId: 0,
        storeAddress: '',
      );
}
