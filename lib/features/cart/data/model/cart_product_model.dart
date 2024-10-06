import 'package:gogreen/features/home/details/data/model/product_detail_model.dart';
import 'package:gogreen/features/home/details/data/model/product_model.dart';

class CartProductModel {
  int quantity;
  int productId;
  String? image;
  String name;
  String price;
  String unit;
  bool isOffer;

  CartProductModel({
    required this.quantity,
    required this.productId,
    this.image,
    required this.name,
    this.price = '0',
    this.unit = '',
    this.isOffer = false,
  });

  factory CartProductModel.fromJson(Map<dynamic, dynamic> json) {
    return CartProductModel(
      quantity: json['quantity'] ?? 0,
      productId: json['product_id'],
      price: json['price'].toString(),
      image: json['image'] ?? '',
      isOffer: json['is_offer'] ?? false,
      unit: json['unit'] ?? '',
      name: json['name'] ?? '',
    );
  }

  //From Product Detail Model
  CartProductModel.fromProductDetailModel(ProductDetailModel product, int qty)
      : quantity = qty,
        productId = product.id,
        price = product.price ?? "0",
        image = product.image,
        isOffer = false,
        unit = product.unit ?? "",
        name = product.name;

  //from productModel
  CartProductModel.fromProductModel(ProductModel product)
      : quantity = 1,
        productId = product.id,
        price = product.price,
        image = product.image,
        isOffer = false,
        unit = product.unit,
        name = product.name;

  Map<String, dynamic> toJson() {
    return {
      'quantity': quantity,
      'product_id': productId,
      'image': image,
      'price': price,
      'name': name,
      'unit': unit,
    };
  }

  static CartProductModel empty() {
    return CartProductModel(
      quantity: 0,
      productId: 0,
      image: '',
      name: '',
    );
  }

  CartProductModel copyWith({
    int? quantity,
    int? productId,
    String? image,
    String? name,
    String? price,
    String? unit,
  }) {
    return CartProductModel(
      quantity: quantity ?? this.quantity,
      productId: productId ?? this.productId,
      image: image ?? this.image,
      name: name ?? this.name,
      price: price ?? this.price,
      unit: unit ?? this.unit,
    );
  }
}
