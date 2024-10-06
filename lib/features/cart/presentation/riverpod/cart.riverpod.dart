import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gogreen/core/helpers/flash_bar_helper.dart';
import 'package:gogreen/core/states/data.state.dart';
import 'package:gogreen/core/states/generateData.state.dart';
import 'package:gogreen/features/cart/data/model/cart.model.dart';
import 'package:gogreen/features/cart/data/model/cart_product_model.dart';
import 'package:gogreen/features/cart/data/model/confirm_order_data_model.dart';
import 'package:gogreen/features/cart/data/model/send_order_model.dart';
import 'package:gogreen/features/cart/data/repositories/cart_repo.dart';
import 'package:gogreen/features/cart/presentation/widgets/order_data_form_widget.dart';
import 'package:gogreen/features/home/main/data/model/company_model.dart';
import 'package:gogreen/locator.dart';
import 'cart.state.dart';

final cartProvider =
    StateNotifierProvider.autoDispose<CartRiverpodController, CartState>((ref) {
  return CartRiverpodController();
});

class CartRiverpodController extends StateNotifier<CartState> {
  CartRiverpodController() : super(CartState.initial()) {
    getFromHive();
  }

  final _controller = locator<CartReposaitories>();
  static OrderDataFormController orderFormController =
      OrderDataFormController();

  bool isValid() {
    orderFormController.group.markAllAsTouched();
    return orderFormController.group.valid;
  }

  Future<bool> updateCompany(
    CompanyModel company, {
    bool force = false,
    bool detail = false,
  }) async {
    if (force ||
        (state.company != null &&
            state.company!.id != 0 &&
            state.company!.id != company.id &&
            state.data.products.isNotEmpty)) {
      _showDialog(detail);
      return false;
    }

    await _controller.addACompanyToCart(company);
    state = state.copyWith(
      company: company,
    );
    return true;
  }

  void _showDialog(bool inDetailView) {
    if (!inDetailView) {
      state = state.copyWith(changeCompany: true);
      Future.delayed(const Duration(seconds: 1), () {
        state = state.copyWith(changeCompany: false);
      });
    } else {
      state = state.copyWith(changeCompanyDetail: true);
      Future.delayed(const Duration(seconds: 1), () {
        state = state.copyWith(changeCompanyDetail: false);
      });
    }
  }

  /// Add or update a product to your cart
  addOrUpdateCart({
    required CartProductModel product,
    required bool increment,
  }) async {
    var index = state.data.products.indexWhere(
      (element) => element.productId == product.productId,
    );

    if (increment) {
      await _controller.addAProductToCart(product);
      if (index == -1) {
        state = state.copyWith(
          data:
              state.data.copyWith(products: [...state.data.products, product]),
        );
      } else {
        state = state.copyWith(
          data: state.data.copyWith(
            products: state.data.products.map((e) {
              if (e.productId == product.productId) {
                return e.copyWith(quantity: e.quantity + product.quantity);
              }
              return e;
            }).toList(),
          ),
        );
      }
    } else {
      if (index == -1) return;

      var productIndex = state.data.products[index];

      if (productIndex.quantity <= 1) {
        await _controller.removeFromCart(product.productId);

        state = state.copyWith(
          data: state.data.copyWith(
            products: state.data.products
                .where((e) => e.productId != product.productId)
                .toList(),
          ),
        );
        if (state.data.products.isEmpty) {
          clearAllCart();
        }
      } else {
        await _controller.updateCartQuantity(
            product.productId, productIndex.quantity - 1);
        state = state.copyWith(
          data: state.data.copyWith(
            products: state.data.products.map((e) {
              if (e.productId == product.productId) {
                return e.copyWith(quantity: e.quantity - 1);
              }
              return e;
            }).toList(),
          ),
        );
      }
    }

    //check if the products is empty clear the cart
    if (state.data.products.isEmpty) {
      clearAllCart();
    }
  }

  /// Clear all cart products and Company Information
  clearAllCart() async {
    await _controller.clearCart();
    await _controller.clearCompany();
    state = state.copyWith(
      data: CartModel.empty(),
      company: CompanyModel.empty(),
    );
  }

  /// Get All Cart Products And Get Company Information
  getFromHive() async {
    var cart = await _controller.getAllCart();
    var company = await _controller.getCompany();
    if (cart.products.isEmpty) {
      await _controller.clearCompany();
      company = null;
    }
    state = state.copyWith(
      data: cart,
      company: company,
    );
  }

  Future<void> send({
    required BuildContext context,
    required String note,
    required Function onSuccess,
  }) async {
    if (!isValid()) return;
    state = state.loading();
    var form = orderFormController.group.value;
    var order = SendOrderModel(
      addressId: form['address_id'] as int,
      couponId: "",
      vehicleId: form['vehicle_id'] as int,
      companyId: state.company!.id,
      paymentMethodId: 2,
      //form['payment_method'] as int
      note: note,
      products: SendOrderProductModel.fromCartProductList(state.data.products),
      phone: "",
      purchaseId: "",
      otp: "",
      kuraimiPurchaseNumber: "",
    );
    var data = await _controller.sendOrder(order);
    if (data is DataSuccess) {
      clearAllCart();
      onSuccess();
      state = state.success(data: state.data);
    } else {
      showFlashBarError(
        context: context,
        message: data.message,
      );
      state = state.failure(data.message);
    }
  }
}

final getConfirmOrderDataProvider = StateNotifierProvider.autoDispose<
    GetConfirmOrderDataController, GenerateDataState<ConfirmOrderDataModel>>(
  (ref) => GetConfirmOrderDataController(),
);

class GetConfirmOrderDataController
    extends StateNotifier<GenerateDataState<ConfirmOrderDataModel>> {
  GetConfirmOrderDataController()
      : super(GenerateDataState<ConfirmOrderDataModel>.initial(
            ConfirmOrderDataModel.empty())) {
    getData();
  }

  final _orderController = locator<CartReposaitories>();

  Future<void> getData() async {
    state = state.loading();
    final data = await _orderController.getConfirmOrderData();

    if (data is DataSuccess) {
      state = state.success(data.data!);
    } else {
      state = state.failure(data.message, error: data.error);
    }
  }
}
