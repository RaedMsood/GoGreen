import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/core/widget/appbar_sliver_persistent_header_widget.dart';
import 'package:gogreen/core/widget/appbar_widget.dart';
import 'package:gogreen/core/widget/auto_size_text_widget.dart';
import 'package:gogreen/core/widget/general_design_of_the_company_card_widget.dart';
import 'package:gogreen/core/helpers/navigateTo.dart';
import 'package:gogreen/features/cart/presentation/pages/confirm_order_page.dart';
import 'package:gogreen/features/cart/presentation/riverpod/cart.riverpod.dart';
import 'package:gogreen/features/cart/presentation/widgets/total_and_confirm_order_bottom_bar_widget.dart';
import 'package:gogreen/features/cart/presentation/widgets/list_of_products_cart_card_widget.dart';
import 'package:gogreen/features/services/auth/auth.dart';
import 'package:gogreen/features/user/presentation/pages/login_page.dart';

class CartPage extends ConsumerWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    var controller = ref.watch(cartProvider);

    return Scaffold(
      appBar:
          controller.data.products.isEmpty ? AppBarWidget(title: "Cart") : null,
      body: CustomScrollView(
        slivers: [
          if (controller.data.products.isNotEmpty)
            SliverPersistentHeader(
              pinned: true,
              floating: false,
              delegate: AppbarSliverPersistentHeaderWidget(
                title: "Cart",
                expandedHeight: 234.h,
                child: GeneralDesignOfTheCompanyCardWidget(
                  image: controller.company!.image.toString(),
                  name: controller.company!.name.toString(),
                  evaluation: double.parse(controller.company!.rates.toString()),
                  address: controller.company!.address.toString(),
                ),
              ),
            ),
          if (controller.data.products.isNotEmpty)
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),
                child: const AutoSizeTextWidget(
                  text: "Products",
                ),
              ),
            ),
          const SliverToBoxAdapter(
            child: ListOfProductsCartCardWidget(),
          ),

        ],
      ),
      bottomNavigationBar: controller.data.products.isEmpty
          ? const SizedBox()
          : TotalAndConfirmOrderBottomBarWidget(
              total: controller.totalPrice.toString(),
              onPressed: () {
                if (!Auth().loggedIn) {
                  navigateTo(
                    context,
                    const LogInPage(),
                  );
                } else {
                  navigateTo(
                    context,
                    ConfirmOrderPage(
                      total: controller.totalPrice.toString(),
                    ),
                  );
                }
              },
            ),
    );
  }
}
