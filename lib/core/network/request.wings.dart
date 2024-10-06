import 'package:gogreen/features/services/auth/auth.dart';

class WingsRequest {
  String url;
  dynamic id;
  bool shouldCache;
  Map<String, dynamic> queryString;
  Map<String, dynamic> _header;
  dynamic body;
  bool withPagination;

  WingsRequest({
    required this.url,
    this.id,
    this.shouldCache = false,
    this.queryString = const {},
    this.body = const {},
    this.withPagination = false,
    Map<String, dynamic> header = const {},
  }) : _header = header;

  String get withId => id != null ? '/$id' : '';

  String get urlQueryString => url + withId + _queryStringFormat();

  Map<String, dynamic> get header {
    var head = Map<String, dynamic>.from(_header);

    if (Auth().token.isNotEmpty) {
      head.addAll({"authorization": "Bearer " + Auth().token});
    }
    return head;
  }

  String _queryStringFormat() {
    String query = withPagination ? '?' : '';

    if (queryString.isNotEmpty) {
      query = withPagination ? '$query&' : '?';

      queryString.forEach((key, value) {
        query += '$key=$value&';
      });

      query = query.substring(0, query.length - 1);
    }
    return query;
  }
}
