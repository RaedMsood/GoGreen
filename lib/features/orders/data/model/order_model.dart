import 'order_company_model.dart';
import 'order_status_model.dart';

class OrderModel {
  final int id;
  final int userId;
  final int companyId;
  final String transactionId;
  final String date;
  final num total;
  final OrderCompanyModel company;
  final OrderStatusModel status;
  final int numberOfProducts;

  OrderModel({
    required this.id,
    required this.userId,
    required this.companyId,
    required this.transactionId,
    required this.date,
    required this.total,
    required this.company,
    required this.status,
    required this.numberOfProducts,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: (json['id'] as num).toInt(),
      userId: (json['user_id'] as num).toInt(),
      companyId: (json['company_id'] as num).toInt(),
      transactionId: json['trx_id'] as String,
      date: json['date'] as String,
      total: json['total_payable'] as num,
      numberOfProducts: json['total_products'],
      status: OrderStatusModel.fromJson(json['status'] as Map<String, dynamic>),
      company:
          OrderCompanyModel.fromJson(json['company'] as Map<String, dynamic>),
    );
  }

  /// from json list
  static List<OrderModel> fromJsonList(List<dynamic> json) {
    return json.map((e) => OrderModel.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'company_id': companyId,
      'trx_id': transactionId,
      'date': date,
      'total_payable': total,
      'total_products': numberOfProducts,
      'status': status,
      'company': company,
    };
  }

  /// empty
  factory OrderModel.empty() => OrderModel(
        id: 0,
        userId: 0,
        companyId: 0,
        transactionId: '0',
        date: '',
        total: 0,
        numberOfProducts: 0,
        company: OrderCompanyModel(id: 0, name: ''),
        status: OrderStatusModel.empty(),
      );
}
