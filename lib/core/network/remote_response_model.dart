class RemoteResponse {
  final String code;
  final int statusCode;
  final String message;
  final dynamic data;
  final bool success;

  RemoteResponse({
    required this.code,
    required this.statusCode,
    required this.message,
    required this.data,
    required this.success,
  });

  factory RemoteResponse.fromJson(Map<String, dynamic> json) {
    // convert the code from int to string
    if (json['code'] is int) {
      json['code'] = json['code'].toString();
    }

    return RemoteResponse(
      statusCode: json['statusCode'],
      code: json['code'] ?? '0',
      message: json['message'],
      data: json['data'],
      success: json['success'] ?? false,
    );
  }

  RemoteResponse copyWith({
    required String message,
  }) {
    return RemoteResponse(
      message: message,
      data: data,
      statusCode: statusCode,
      success: success,
      code: code,
    );
  }

  factory RemoteResponse.empty() => RemoteResponse(
        statusCode: 200,
        code: '000',
        message: '',
        data: null,
        success: false,
      );
}
