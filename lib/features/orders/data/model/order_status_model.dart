class OrderStatusModel {
  final int status;
  final String name;
  final String backgroundColor;
  final String textColor;

  OrderStatusModel({
    required this.status,
    required this.name,
    required this.backgroundColor,
    required this.textColor,
  });

  factory OrderStatusModel.fromJson(Map<String, dynamic> json) {
    return OrderStatusModel(
      status: (json['id'] as num).toInt(),
      name: json['name'] as String,
      backgroundColor: json['background_color'] as String,
      textColor: json['font_color'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': status,
      'name': name,
      'background_color': backgroundColor,
      'font_color': textColor,
    };
  }

  //empty
  factory OrderStatusModel.empty() => OrderStatusModel(
        status: 0,
        name: '',
        backgroundColor: '',
        textColor: '',
      );
}
