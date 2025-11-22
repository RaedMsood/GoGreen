import 'dart:io';
import 'package:dio/dio.dart';
import 'package:gogreen/core/network/urls.dart';
import 'package:gogreen/features/services/auth/auth.dart';
import '../logger.dart';
import 'remote_response_model.dart';
import 'methods.enums.wings.dart';
import 'request.wings.dart';
export '../../../../core/states/data.state.dart';
export 'methods.enums.wings.dart';
export 'request.wings.dart';
export 'urls.dart';

class WingsRemoteService {
  factory WingsRemoteService() {
    _singleton ??= WingsRemoteService._();

    _singleton!.dio.options = BaseOptions(
      baseUrl: AppURL.baseURL,
      connectTimeout: const Duration(seconds: 120),
      receiveTimeout: const Duration(seconds: 120),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.acceptLanguageHeader: 'en',
      },
    );
    return _singleton!;
  }

  WingsRemoteService._();

  static WingsRemoteService? _singleton;

  Dio dio = Dio();

  Future<dynamic> send({
    required WingsRequest request,
    required WingsRemoteMethod method,
    List<int> successStates = const [200, 201, 202],
    required Function(RemoteResponse, int) onSuccess,
    required Function(RemoteResponse, int) onError,
  }) async {
    int errorStatusCode = 500;
    RemoteResponse _remoteResponse = RemoteResponse(
      code: 'unknown',
      message: '',
      data: null,
      success: false,
      statusCode: 500,
    );

    //add auth token to the header
    if (Auth().token.isNotEmpty) {
      dio.options.headers[HttpHeaders.authorizationHeader] =
          'Bearer ${Auth().token}';
    }
    wingsLogger.logInfo('Request Auth: ${Auth().token}');
    wingsLogger.logInfo('Request: ${request.urlQueryString}');
    wingsLogger.logInfo('Request Body: ${request.body}');
    try {
      final body = request.body;

      final bool hasBody = body != null && body is Map && body.isNotEmpty;

      Response<dynamic> response = await dio.request(
        request.urlQueryString,
        data: hasBody ? body : null,
        options: Options(
          method: method.name,
          headers: {
            HttpHeaders.acceptLanguageHeader: 'en',
            HttpHeaders.authorizationHeader: 'Bearer ${Auth().token}',
            ...request.header,
          },
          validateStatus: (status) {
            return status != null && status < 500;
          },
        ),
      );

      var statusCode = response.statusCode!;

      _remoteResponse =
          RemoteResponse.fromJson({"statusCode": statusCode, ...response.data});

      if (successStates.contains(statusCode) &&
          response.data['success'] == true) {
        return onSuccess(_remoteResponse, statusCode);
      } else {
        wingsLogger.logInfo(response.data.toString());
        wingsLogger.logInfo(statusCode.toString());

        _remoteResponse = _remoteResponse.copyWith(
          message: _remoteResponse.message,
        );
        return onError(_remoteResponse, statusCode);
      }
    } catch (exception) {
      return onError(_remoteResponse, errorStatusCode);
    }
  }
}
