import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/core/constants/app_icons.dart';
import 'package:gogreen/core/theme/app_colors.dart';
import 'package:gogreen/core/helpers/flash_bar_helper.dart';
import 'package:gogreen/core/widget/auto_size_text_widget.dart';
import 'package:gogreen/core/widget/buttons/default_button.dart';
import 'package:gogreen/core/widget/buttons/small_Icon_button_widget.dart';
import 'package:gogreen/core/helpers/navigateTo.dart';
import 'package:gogreen/features/home/details/presentation/widgets/clear_prev_cart_dialog_widget.dart';
import 'package:gogreen/features/cart/data/model/cart_product_model.dart';
import 'package:gogreen/features/cart/presentation/pages/cart_page.dart';
import 'package:gogreen/features/cart/presentation/riverpod/cart.riverpod.dart';
import 'package:gogreen/features/home/details/presentation/riverpod/company_detail_riverpod.dart';
import 'package:gogreen/features/home/main/data/model/company_model.dart';

final prodQty = StateProvider.autoDispose((ref) => 1);

class AddToCartBottomBarWidget extends ConsumerWidget {
  final int productId;
  dynamic price;
  final CompanyModel company;
  final Future<bool> Function(int) onAdd;

  AddToCartBottomBarWidget({
    super.key,
    required this.productId,
    required this.price,
    required this.company,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context, ref) {
    var controllerProductDetail = ref.watch(productDetailProvider(productId));
    var controller = ref.watch(cartProvider);
    var offerQuantity = ref.watch(prodQty);

    var productQuantityInCart = controller.data.products.firstWhere(
      (element) => element.productId == productId,
      orElse: () {
        return CartProductModel.empty();
      },
    ).quantity;

    var index = controller.data.products.indexWhere(
      (element) => element.productId == productId,
    );

    /// Function to increment or decrement the quantity of a product in the cart
    incrementOrDecrementQuantity(bool increment) {
      var cart = CartProductModel.fromProductDetailModel(
        controllerProductDetail.data,
        1,
      );
      ref.read(cartProvider.notifier).addOrUpdateCart(
            product: cart,
            increment: increment,
          );
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.09),
            blurRadius: 4.r,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AutoSizeTextWidget(
                text:
                    "\$${productQuantityInCart > 0 ? (num.parse(price) * productQuantityInCart).toString() : num.parse(price) * offerQuantity}",
                colorText: AppColors.brownColor,
                fontSize: 12.5.sp,
                fontWeight: FontWeight.w700,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                textDirection: TextDirection.rtl,
                children: [
                  SmallIconButtonWidget(
                    icon: AppIcons.plus,
                    onPressed: () {
                      ref.read(prodQty.notifier).state += 1;
                      if (index != -1) {
                        incrementOrDecrementQuantity(true);
                      }
                    },
                  ),
                  6.w.horizontalSpace,
                  AutoSizeTextWidget(
                    text: productQuantityInCart > 0
                        ? productQuantityInCart.toString()
                        : offerQuantity.toString(),
                    fontSize: 12.5.sp,
                    textAlign: TextAlign.center,
                  ),
                  6.w.horizontalSpace,
                  SmallIconButtonWidget(
                    icon: AppIcons.minus,
                    onPressed: () {
                      if (offerQuantity > 1) {
                        ref.read(prodQty.notifier).state -= 1;
                      }
                      if (index != -1) {
                        incrementOrDecrementQuantity(false);
                        if (productQuantityInCart == 1) {
                          showFlashBarSuccess(
                            message: 'Deleted successfully',
                            context: context,
                          );
                        }
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
          16.h.verticalSpace,
          if (index == -1)
            DefaultButtonWidget(
              text: "Add To Cart",
              textSize: 13.sp,
              onPressed: () async {
                var canAdd =
                    await ref.read(cartProvider.notifier).updateCompany(
                          company,
                          detail: true,
                        );

                if (ref.read(cartProvider).changeCompanyDetail) {
                  var value =
                      await ClearPrevCartDialogWidget.show(context, () async {
                    await ref
                        .read(cartProvider.notifier)
                        .clearAllCart()
                        .then((v) async {
                      return await ref
                          .read(cartProvider.notifier)
                          .updateCompany(company);
                    });

                    return true;
                  });

                  if (value) {
                    await onAdd(ref.read(prodQty));
                  }
                  return;
                }
                if (canAdd) {
                  await onAdd(ref.read(prodQty));
                }
              },
            )
          else
            DefaultButtonWidget(
              text: "Show Cart",
              textSize: 13.sp,
              onPressed: () {
                navigateTo(context, const CartPage());
              },
            ),
        ],
      ),
    );
  }
}
