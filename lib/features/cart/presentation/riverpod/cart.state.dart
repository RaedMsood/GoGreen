import 'package:gogreen/core/network/errors/error.model.wings.dart';
import 'package:gogreen/core/states/view.state.dart';
import 'package:gogreen/features/cart/data/model/cart_model.dart';
import 'package:gogreen/features/cart/data/model/cart_product_model.dart';
import 'package:gogreen/features/home/main/data/model/company_model.dart';



class CartState {
  ViewState viewState;
  final CartModel data;
  final CartProductModel productModel;

  final CompanyModel? company;

  final bool changeCompany;
  final bool changeCompanyDetail;

   String message;
  ErrorModel errorModel;

  num get totalPrice => data.products.fold(
        0,
        (previousValue, element) =>
            previousValue +
            (num.tryParse(element.price) ?? 0) * element.quantity,
      );

  CartState(
      {required this.viewState,
      required this.data,
      this.changeCompany = false,
      this.changeCompanyDetail = false,
      this.company,
      required this.productModel,
       this.message = '',
      required this.errorModel});

  factory CartState.initial() {
    return CartState(
      viewState: ViewState.initial,
      data: CartModel.empty(),
      company: CompanyModel.empty(),
      productModel: CartProductModel.empty(),
      errorModel: ErrorModel(),
    );
  }

  CartState copyWith({
    ViewState? viewState,
    CartModel? data,
    CartProductModel? productModel,
    CompanyModel? company,
    bool? changeCompany,
    bool? changeCompanyDetail,
    ErrorModel? errorModel,
  }) {
    return CartState(
      viewState: viewState ?? this.viewState,
      data: data ?? this.data,
      company: company ?? this.company,
      productModel: productModel ?? this.productModel,
      changeCompany: changeCompany ?? this.changeCompany,
      changeCompanyDetail: changeCompanyDetail ?? this.changeCompanyDetail,
      errorModel: errorModel ?? this.errorModel,
    );
  }

  num get totalProductPrice {
    return data.products.fold(
      0,
      (previousValue, element) =>
          previousValue + (num.tryParse(element.price) ?? 0) * element.quantity,
    );
  }

  num get totalDeliveryPrice {
    return 0;

    ///data.deliveryPrice ??
  }

// double get deliveryDiscount {
//   return coupons
//       .where((element) => element.scope == CouponScopeEnum.delivery)
//       .fold(
//     0.0,
//     (previousValue, element) {
//       if (element.type == CouponTypeEnum.percent) {
//         return previousValue + (element.amount) * totalDeliveryPrice / 100;
//       }
//       return previousValue + (element.amount) * 1.0;
//     },
//   );
// }

// double get productDiscount {
//   return coupons
//       .where((element) => element.scope == CouponScopeEnum.product)
//       .fold(
//     0.0,
//     (previousValue, element) {
//       if (element.type == CouponTypeEnum.percent) {
//         return previousValue + (element.amount) * totalProductPrice / 100;
//       }
//       return previousValue + (element.amount);
//     },
//   );
// }

// double get totalDiscountPrice {
//   return productDiscount + deliveryDiscount;
// }

// num get totalPriceAfterDiscount {
//   return totalProductPrice + totalDeliveryPrice - totalDiscountPrice;
// }

  CartState loading() {
    return CartState(
      viewState: ViewState.loading,
      errorModel: errorModel,
      data: data,
      company: company,
      changeCompany: changeCompany,
      changeCompanyDetail: changeCompanyDetail,
      productModel: productModel,
    );
  }

  CartState success(
      {required CartModel data,
        CompanyModel? company,
       }) {
    return CartState(
      viewState: ViewState.success,
      errorModel: errorModel,
      data: data,
      company: company ?? this.company,
      changeCompany: changeCompany,
      changeCompanyDetail: changeCompanyDetail,
      productModel: productModel,
    );
  }

  CartState failure(String message, {ErrorModel? error}) {
    return CartState(
      viewState: ViewState.failure,
      message: message,
      errorModel: error ?? ErrorModel(),
      data: data,
      company: company,
      changeCompany: changeCompany,
      changeCompanyDetail: changeCompanyDetail,
      productModel: productModel,
    );
  }
}
