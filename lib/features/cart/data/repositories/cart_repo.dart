import 'package:gogreen/core/network/errors/error.model.wings.dart';
import 'package:gogreen/core/network/remote.wings.dart';
import 'package:gogreen/features/cart/data/data_sourse/cart_hive_local.dart';
import 'package:gogreen/features/cart/data/data_sourse/company_cart_hive_local.dart';
import 'package:gogreen/features/cart/data/model/cart_model.dart';
import 'package:gogreen/features/cart/data/model/cart_product_model.dart';
import 'package:gogreen/features/cart/data/model/confirm_order_data_model.dart';
import 'package:gogreen/features/cart/data/model/send_order_model.dart';
import 'package:gogreen/features/home/main/data/model/company_model.dart';

class CartReposaitories {
  Future<void> addAProductToCart(CartProductModel cartProduct) async {
    try {
      await CartHiveLocal().addToCart(cartProduct.toJson());
    } catch (e) {
      throw '$e';
    }
  }

  Future<void> addACompanyToCart(CompanyModel cartCompany) async {
    try {
      await CompanyCartHiveLocal().setCompany(cartCompany);
    } catch (e) {
      throw '$e';
    }
  }

  Future<CartModel> getAllCart() async {
    try {
      return await CartHiveLocal().getCart();
    } catch (e) {
      throw '$e';
    }
  }

  Future<CompanyModel?> getCompany() async {
    try {
      return await CompanyCartHiveLocal().getCompany();
    } catch (e) {
      throw '$e';
    }
  }

  Future<void> updateCartQuantity(int productId, int quantity) async {
    try {
      await CartHiveLocal().updateCartQuantity(productId, quantity);
    } catch (e) {
      throw '$e';
    }
  }

  Future<void> removeFromCart(int id) async {
    try {
      await CartHiveLocal().removeFromCart(id);
    } catch (e) {
      throw '$e';
    }
  }

  Future<void> clearCart() async {
    try {
      await CartHiveLocal().clearCart();
    } catch (e) {
      throw '$e';
    }
  }

  Future<void> clearCompany() async {
    try {
      await CompanyCartHiveLocal().clear();
    } catch (e) {
      throw '$e';
    }
  }

  Future<DataState<ConfirmOrderDataModel>> getConfirmOrderData() async {
    return await WingsRemoteService().send(
      request: WingsRequest(
        url: AppURL.orderData,
      ),
      method: WingsRemoteMethod.get,
      onSuccess: (response, code) {
        return DataSuccess<ConfirmOrderDataModel>(
          ConfirmOrderDataModel.fromJson(response.data),
        );
      },
      onError: (response, code) {
        return DataError<ConfirmOrderDataModel>(
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

  Future<DataState<bool>> sendOrder(SendOrderModel sendOrderModel) async {
    return await WingsRemoteService().send(
      request: WingsRequest(
        url: AppURL.sendOrder,
        body: sendOrderModel.toJson(),
      ),
      method: WingsRemoteMethod.post,
      onSuccess: (response, code) {
        return DataSuccess(true);
      },
      onError: (response, code) {
        return DataError<bool>(
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
