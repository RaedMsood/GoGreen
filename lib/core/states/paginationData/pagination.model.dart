class PaginationModel<T> {
  final int currentPage;
  final int lastPage;
  final int perPage;
  final int total;
  final List<T> data;

  PaginationModel({
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
    required this.data,
  });

  //from json
  factory PaginationModel.fromJson(Map<String, dynamic> json, T Function(dynamic json) fromJson) {
    return PaginationModel<T>(
      currentPage: json['current_page'],
      lastPage: json['last_page'],
      perPage: json['per_page'],
      total: json['total'],
      data: List<T>.from(json['data'].map((x) => fromJson(x))),
    );
  }

  //to json
  Map<String, dynamic> toJson(Map<String, dynamic> Function(T data) toJson) {
    return {
      'current_page': currentPage,
      'last_page': lastPage,
      'per_page': perPage,
      'total': total,
      'data': List<dynamic>.from(data.map((x) => toJson(x))),
    };
  }

  PaginationModel<T> copyWith({
    int? currentPage,
    int? lastPage,
    int? perPage,
    int? total,
    List<T>? data,
  }) {
    return PaginationModel<T>(
      currentPage: currentPage ?? this.currentPage,
      lastPage: lastPage ?? this.lastPage,
      perPage: perPage ?? this.perPage,
      total: total ?? this.total,
      data: data ?? this.data,
    );
  }


  //empty
  factory PaginationModel.empty() {
    return PaginationModel<T>(
      currentPage: 0,
      lastPage: 0,
      perPage: 0,
      total: 0,
      data: [],
    );
  }

}