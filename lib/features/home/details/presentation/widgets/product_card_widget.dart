import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gogreen/core/helpers/flash_bar_helper.dart';
import 'package:gogreen/core/helpers/navigateTo.dart';
import 'package:gogreen/core/widget/product_card_design_widget.dart';
import 'package:gogreen/features/cart/data/model/cart_product_model.dart';
import 'package:gogreen/features/cart/presentation/riverpod/cart.riverpod.dart';
import 'package:gogreen/features/home/details/data/model/product_model.dart';
import 'package:gogreen/features/home/details/presentation/pages/product_details_page.dart';

class ProductCardWidget extends ConsumerWidget {
  final ProductModel product;
  final String companyName;
  var quantity = 0;
  final Future<bool> Function() onAddToCart;

  ProductCardWidget({
    super.key,
    required this.product,
    required this.companyName,
    required this.onAddToCart,
  });

  navigateToOrderDetails(BuildContext context) {
    navigateTo(
        context,
        ProductDetailsPage(
          companyName: companyName.toString(),
          productId: product.id,
        ));
  }

  @override
  Widget build(BuildContext context, ref) {
    var cartController = ref.watch(cartProvider);

    quantity = cartController.data.products.firstWhere(
      (element) => element.productId == product.id,
      orElse: () {
        return CartProductModel.empty();
      },
    ).quantity;

    return GestureDetector(
      onTap: () {
        if (quantity < 1) {
          navigateToOrderDetails(context);
        }
      },
      child: ProductCardDesignWidget(
        image: product.image,
        name: product.name,
        unit: product.unit,
        price: quantity > 0
            ? (num.parse(product.price) * quantity).toString()
            : product.price,
        quantity: quantity,
        clickOnTheImage: () {
          navigateToOrderDetails(context);
        },
        increment: () async {
          if (await onAddToCart()) {
            var cart = CartProductModel.fromProductModel(
              product,
            );
            ref.read(cartProvider.notifier).addOrUpdateCart(
                  product: cart,
                  increment: true,
                );
            if (quantity < 1) {
              showFlashBarSuccess(
                context: context,
                message:  'Added to cart successfully',
              );

            }
          }
        },
        decrement: () {
          var cart = CartProductModel.fromProductModel(
            product,
          );
          ref.read(cartProvider.notifier).addOrUpdateCart(
                product: cart,
                increment: false,
              );
          if (quantity == 1) {
            showFlashBarSuccess(
              message: 'Deleted successfully',
              context: context,
            );
          }
        },
      ),
    );
  }
}
