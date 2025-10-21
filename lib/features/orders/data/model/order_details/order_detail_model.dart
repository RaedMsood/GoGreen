import '../order_status_model.dart';
import 'order_detail_company_and_product_model.dart';
import 'order_detail_user_and_address_model.dart';
import 'order_detail_vehicle_and_review_model.dart';

class OrderDetailModel {
  final int id;
  final String transactionId;
  final String date;
  final num total;
  final num discount;
  final num deliveryPrice;
  final num productsPrice;
  final OrderDetailUserModel user;
  final OrderAddressModel address;
  final OrderDetailVehicleModel vehicleType;
  final OrderStatusModel status;
  final OrderDetailCompanyModel company;
  final List<OrderDetailProductModel> products;
  final String? note;

  OrderDetailModel({
    required this.id,
    required this.transactionId,
    required this.date,
    required this.total,
    required this.discount,
    required this.deliveryPrice,
    required this.productsPrice,
    required this.user,
    required this.address,
    required this.vehicleType,
    required this.company,
    required this.status,
    required this.products,
    this.note,
  });

  factory OrderDetailModel.fromJson(Map<String, dynamic> json) {
    return OrderDetailModel(
      id: (json['id'] as num).toInt(),
      user: OrderDetailUserModel.fromJson(json['user'] as Map<String, dynamic>),
      transactionId: json['trx_id'] as String,
      date: json['date'] as String,
      address: OrderAddressModel.fromJson(
          json['order_address'] as Map<String, dynamic>),
      total: json['total_payable'] as num,
      vehicleType: OrderDetailVehicleModel.fromJson(
          json['vehicle_type'] as Map<String, dynamic>),
      discount: json['discount'] as num,
      deliveryPrice: json['delivery_total'] as num,
      productsPrice: json['products_total'] as num,
      status: OrderStatusModel.fromJson(json['status'] as Map<String, dynamic>),
      company: OrderDetailCompanyModel.fromJson(
          json['company'] as Map<String, dynamic>),
      note: json['note'] as String?,
      products: (json['order_products'] as List<dynamic>)
          .map((e) =>
              OrderDetailProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),

    );
  }

  /// from json list
  static List<OrderDetailModel> fromJsonList(List<dynamic> json) {
    return json.map((e) => OrderDetailModel.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user,
      'trx_id': transactionId,
      'date': date,
      'order_address': address,
      'total_payable': total,
      'vehicle_type': vehicleType,
      'discount': discount,
      'delivery_total': deliveryPrice,
      'products_total': productsPrice,
      'status': status,
      'company': company,
      'note': note,
      'order_products': products,
      // 'reviews': reviews,
    };
  }

  /// Empty
  factory OrderDetailModel.empty() => OrderDetailModel(
        id: 0,
        transactionId: '0',
        date: '',
        total: 0,
        deliveryPrice: 0,
        productsPrice: 0,
        discount: 0,
        vehicleType: OrderDetailVehicleModel.empty(),
        company: OrderDetailCompanyModel(id: 0, name: '',rates: 0.0),
        status: OrderStatusModel.empty(),
        user: OrderDetailUserModel.empty(),
        products: [],
        address: OrderAddressModel.empty(),
        note: '',
      );
}
