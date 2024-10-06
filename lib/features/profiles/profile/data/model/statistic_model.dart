class StatisticModel {
  List<ItemModel> productsCount;
  List<ItemModel> mostOrder;

  StatisticModel({required this.productsCount, required this.mostOrder});

  factory StatisticModel.fromJson(Map<String, dynamic> json) {
    return StatisticModel(
      productsCount:(json['products_count'] as List)
          .map((i) => ItemModel.fromJson(i))
          .toList(),

      mostOrder: (json['most_orderd'] as List)
          .map((i) => ItemModel.fromJson(i))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // 'products_count': productsCount.map((i) => i.toJson()).toList(),
      'most_orderd': mostOrder.map((i) => i.toJson()).toList(),
    };
  }

  //empty
  factory StatisticModel.empty() {
    return StatisticModel(
      productsCount:[] ,
      mostOrder: [],
    );
  }
}

class ItemModel {
  String color;
  String name;
  int value;

  ItemModel({required this.color, required this.name, required this.value});

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      color: json['color'],
      name: json['name'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'color': color,
      'name': name,
      'value': value,
    };
  }
}
