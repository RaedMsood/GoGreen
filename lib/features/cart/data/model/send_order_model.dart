import 'cart_product_model.dart';

class SendOrderModel{

  final int addressId;
  final int vehicleId;
  final int companyId;
  final int paymentMethodId;
  final String? couponId;
  final String? phone;
  final String? purchaseId;
  final String? otp;
  final String? kuraimiPurchaseNumber;
  final String? note;
  final List<SendOrderProductModel> products;
  SendOrderModel({
    required this.addressId,
    required this.vehicleId,
    required this.companyId,
    required this.paymentMethodId,
    required this.couponId,
    required this.phone,
    required this.purchaseId,
    required this.otp,
    required this.kuraimiPurchaseNumber,
     this.note,
    required this.products,

  });

  factory SendOrderModel.fromJson(Map<String, dynamic> json) {
    return SendOrderModel(
      addressId: (json['address_id'] as num).toInt(),
      vehicleId: (json['vehicle_type_id'] as num).toInt(),
      companyId: (json['company_id'] as num).toInt(),
      couponId: json['coupon_id'] as String? ?? '',
      phone: json['phone_number'] as String? ?? '',
      purchaseId: json['purchase_id'] as String? ?? '',
      otp: json['otp'] as String? ?? '',
      kuraimiPurchaseNumber: json['kuraimi_purchase_number'] as String? ?? '',
      paymentMethodId: (json['payment_method'] as num).toInt(),
      note: json['note'] as String? ?? '',
      products: (json['products'] as List<dynamic>)
          .map((e) => SendOrderProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'address_id': addressId,
      'vehicle_type_id': vehicleId,
      'company_id': companyId,
      'coupon_id': couponId,
      'phone_number': phone,
      'purchase_id': purchaseId,
      'otp': otp,
      'kuraimi_purchase_number': kuraimiPurchaseNumber,
      'payment_method': paymentMethodId,
      'note': note,
      'products': List<Map<String, dynamic>>.from(
    products.map((products) => products.toJson())),
    };
  }
}

class SendOrderProductModel{

  final int productId;
  final bool isOffer;
  final int quantity;
  final String name;


  SendOrderProductModel({
    required this.productId,
    required this.isOffer,
    required this.quantity,
    required this.name,
  });

  factory SendOrderProductModel.fromJson(Map<String, dynamic> json) {
    return SendOrderProductModel(
      productId: (json['product_id'] as num).toInt(),
      quantity: (json['quantity'] as num).toInt(),
      isOffer: json['is_offer'] as bool,
      name: json['product_name'] ??"",
    );
  }

  static List<SendOrderProductModel> fromCartProductList(
      List<CartProductModel> cartProducts) {
    return cartProducts
        .map(
          (e) => SendOrderProductModel(
        productId: e.productId,
        quantity: e.quantity,
        isOffer: e.isOffer,
        name: e.name,
      ),
    ).toList();
  }
  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'quantity': quantity,
      'is_offer': isOffer,
      'product_name': name,
    };
  }
}