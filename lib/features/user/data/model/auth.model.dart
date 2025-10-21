import 'package:gogreen/features/user/data/model/user.model.dart';

class AuthModel {
  final String token;
  final UserModel user;

  AuthModel({
    required this.token,
    required this.user,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      token: json['token'] as String,
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'user': user,
    };
  }

  AuthModel copyWith({
     UserModel? user,
  }) {
    return AuthModel(
      token: token,
      user: user??this.user,
    );
  }

  factory AuthModel.empty() => AuthModel(
        token: '',
        user: UserModel.empty(),
      );
}
