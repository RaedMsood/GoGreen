import 'package:gogreen/core/network/errors/error.model.wings.dart';
import 'package:gogreen/core/network/remote.wings.dart';
import 'package:gogreen/core/states/paginationData/pagination.model.dart';
import 'package:gogreen/features/orders/data/model/order_details/order_detail_model.dart';
import 'package:gogreen/features/orders/data/model/order_model.dart';

class OrdersRepository {
  Future<DataState<PaginationModel<OrderModel>>> getAllOrders(
      {required int page, int limit = 20}) async {
    return await WingsRemoteService().send(
      request: WingsRequest(
        url: AppURL.orders,
        queryString: {
          'page': page,
          'perPage': limit,
        },
      ),
      method: WingsRemoteMethod.get,
      onSuccess: (response, code) {
        return DataSuccess(
          PaginationModel<OrderModel>.fromJson(response.data, (comp) {
            return OrderModel.fromJson(comp);
          }),
        );
      },
      onError: (response, code) {
        return DataError<PaginationModel<OrderModel>>(
          message: response.message,
          code: response.code,
          error: ErrorModel.fromCode(
            response.code,
            response.statusCode,
          ),
        );
      },
    );
  }

  Future<DataState<OrderDetailModel>> getOrderDetail({required int id}) async {
    return await WingsRemoteService().send(
      request: WingsRequest(url: AppURL.orderDetail, id: id),
      method: WingsRemoteMethod.get,
      onSuccess: (response, code) {
        var data = response.data;

        return DataSuccess<OrderDetailModel>(
          OrderDetailModel.fromJson(data),
        );
      },
      onError: (response, code) {
        return DataError<OrderDetailModel>(
          message: response.message,
          code: response.code,
          error: ErrorModel.fromCode(
            response.code,
            response.statusCode,
          ),
        );
      },
    );
  }
}
