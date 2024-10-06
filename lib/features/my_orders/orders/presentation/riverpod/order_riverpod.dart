import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gogreen/core/states/data.state.dart';
import 'package:gogreen/core/states/generateData.state.dart';
import 'package:gogreen/core/states/paginatedData.state.dart';
import 'package:gogreen/core/states/view.state.dart';
import 'package:gogreen/features/my_orders/orders/data/model/order_details/order_detail_model.dart';
import 'package:gogreen/features/my_orders/orders/data/model/order_model.dart';
import 'package:gogreen/features/my_orders/orders/data/repositories/orders.repo.dart';
import 'package:gogreen/features/services/auth/auth.dart';
import 'package:gogreen/locator.dart';

final getAllOrdersProvider = StateNotifierProvider.autoDispose<GetAllOrdersController,
    PaginatedData<OrderModel>>(
  (ref) => GetAllOrdersController(),
);

class GetAllOrdersController extends StateNotifier<PaginatedData<OrderModel>> {
  GetAllOrdersController()
      : super(PaginatedData<OrderModel>.initial(
            PaginationModel<OrderModel>.empty())) {
    getData();
  }

  final _controller = locator<OrdersRepository>();

  Future<void> getData({
    bool moreData = false,
  }) async {
    if (!Auth().loggedIn) return;
    if (state.viewState == ViewState.loadingMore ||
        state.viewState == ViewState.loading) return;

    if (moreData) {
      state = state.loadingMore();
    } else {
      state = state.loading();
    }

    int page = state.data.currentPage + 1;
    final data = await _controller.getAllOrders(
      page: page,
    );

    if (data is DataSuccess) {
      state = state.success(data.data!);
      if (!moreData && data.data!.data.isEmpty) {
        state = state.empty(message: 'No Orders');
      }
    } else {
      state = state.failure(
        data.message,
        error: data.error,
      );
    }
  }
}

/// Get order detail Riverpod
final getOrderDetailProvider = StateNotifierProvider.autoDispose.family<
    GetOrderDetailController, GenerateDataState<OrderDetailModel>, int>(
      (ref, int id) {
    return GetOrderDetailController(id);
  },
);

class GetOrderDetailController
    extends StateNotifier<GenerateDataState<OrderDetailModel>> {
  final int id;

  GetOrderDetailController(this.id)
      : super(GenerateDataState<OrderDetailModel>.initial(
      OrderDetailModel.empty())) {
    getData();
  }

  final _controller = locator<OrdersRepository>();

  Future<void> getData() async {
    state = state.loading();

    final data = await _controller.getOrderDetail(id: id);

    if (data is DataSuccess) {
      state = state.success(data.data as OrderDetailModel);
    } else {
      state = state.failure(
        data.message,
        error: data.error,
      );
    }
  }

}





