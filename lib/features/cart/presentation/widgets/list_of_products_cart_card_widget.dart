import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/core/constants/app_images.dart';
import 'package:gogreen/core/helpers/flash_bar_helper.dart';
import 'package:gogreen/core/network/errors/error.model.wings.dart';
import 'package:gogreen/core/states/error.state.dart';
import 'package:gogreen/core/widget/product_card_design_widget.dart';
import 'package:gogreen/features/cart/presentation/riverpod/cart.riverpod.dart';

class ListOfProductsCartCardWidget extends StatelessWidget {
  const ListOfProductsCartCardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, ref, child) {
        var controller = ref.watch(cartProvider);
        if (controller.data.products.isNotEmpty) {
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            itemCount: controller.data.products.length,
            itemBuilder: (_, index) {
              var e = controller.data.products[index];
              return ProductCardDesignWidget(
                image: e.image.toString(),
                name: e.name.toString(),
                unit: e.unit,
                price: (num.parse(e.price) * e.quantity).toString(),
                quantity: e.quantity,
                increment: () {
                  ref.read(cartProvider.notifier).addOrUpdateCart(
                        product: e.copyWith(quantity: 1),
                        increment: true,
                      );
                },
                decrement: () {
                  ref.read(cartProvider.notifier).addOrUpdateCart(
                        product: e.copyWith(quantity: 1),
                        increment: false,
                      );
                  if (e.quantity <= 1) {
                   showFlashBarSuccess(
                      message: 'Deleted successfully',
                      context: context,
                    );
                  }
                },
              );
            },
          );
        }

        return ErrorState.container(
          error: ErrorModel(
            message: 'No products in the cart',
            desc: 'There are no products in the cart currently',
            icon: AppImages.noData,
          ),
        );
      },
    );
  }
}
