
import 'cart_product_model.dart';

class CartModel {
  int? companyId;
  final List<CartProductModel> products;
  num? deliveryPrice;

  CartModel({
    this.companyId,
    required this.products,
     this.deliveryPrice,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      companyId: json['companyId'] ,
      products: List<CartProductModel>.from(
        (json['products'] ).map(
          (prod) => CartProductModel.fromJson(prod),
        ),
      ),
    );
  }

  CartModel copyWith({
    required List<CartProductModel> products,
    num? deliveryPrice,
  }) {
    return CartModel(
      products: products,
      deliveryPrice: deliveryPrice,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'companyId': companyId,
      'products': List<Map<String, dynamic>>.from(
          products.map((products) => products.toJson())),
    };
  }

  static CartModel empty() {
    return CartModel(
      companyId: 0,
      products: [],
    );
  }
}
