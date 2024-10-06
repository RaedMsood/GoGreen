import 'dart:convert';
import 'dart:developer';
import 'package:gogreen/core/local/secure.storage.dart';
import 'package:gogreen/core/logger.dart';
import 'package:gogreen/core/network/remote.wings.dart';
import 'package:gogreen/features/user/data/model/auth.model.dart';
import 'package:gogreen/locator.dart';

class Auth {
  factory Auth() {
    _instance ??= Auth._();

    return _instance!;
  }

  final String _key = 'user';
  final WingsSecureStorage secureStorage = locator<WingsSecureStorage>();

  Auth._() {
    onInit();
  }

  void onInit() async {
    try {
      var read = await secureStorage.read(
        key: _key,
      );

      if (read != null) {
        Map<String, dynamic> map = jsonDecode(read);
        AuthModel authModel = AuthModel.fromJson(map);
        user = authModel;
      }

      wingsLogger.logInfo(user.token.toString());
    } catch (ex) {
      wingsLogger.logError("$ex");
      throw '$ex';
    }
  }

  static Auth? _instance;

  AuthModel user = AuthModel.empty();

  int get id => user.user.id;

  bool get loggedIn => user.token.isNotEmpty;

  String get token => user.token;

  String get storeAddress => user.user.storeAddress.storeAddress;

  String tempEmail = '';

  void setEmail(String email) {
    tempEmail = email;
  }

  Future<void> login(AuthModel data) async {
    user = data;
    wingsLogger.logInfo(user.user.toString().toString());
    _writeToCache();
  }

  _writeToCache() {
    log(jsonEncode(user), name: 'user');
    secureStorage.write(key: _key, value: jsonEncode(user));
  }

  Future<void> cacheOnBoarding(bool value) async {
    return await secureStorage.write(
        key: "SPLASH_SCREEN", value: jsonEncode(value));
  }

  Future<dynamic> getOnBoarding() {
    var onBoarding = secureStorage.read(key: "SPLASH_SCREEN");
    return onBoarding;
  }

  Future logout() async {
    await secureStorage.delete(key: 'fcmToken');
    user = AuthModel.empty();
    await secureStorage.delete(key: _key);
  }
  void updateFcmToken(String fcmToken) async {
    log(fcmToken, name: 'token');
    //save fcmtoken

    if (loggedIn ) {

      await WingsRemoteService().send(
        request: WingsRequest(
          url: AppURL.addFcmToken,
          body: {'fcmToken': fcmToken},
        ),
        method: WingsRemoteMethod.post,
        onSuccess: (response, code) {
          print("RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR");
        },
        onError: (response, code) {},
      );
    }
  }
}
