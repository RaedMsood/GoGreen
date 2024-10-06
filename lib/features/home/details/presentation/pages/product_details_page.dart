import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/core/helpers/flash_bar_helper.dart';
import 'package:gogreen/core/states/error.state.dart';
import 'package:gogreen/core/states/ui.state.dart';
import 'package:gogreen/core/widget/appbar_sliver_persistent_header_widget.dart';
import 'package:gogreen/features/cart/data/model/cart_product_model.dart';
import 'package:gogreen/features/cart/presentation/riverpod/cart.riverpod.dart';
import 'package:gogreen/features/home/details/presentation/riverpod/company_detail_riverpod.dart';
import 'package:gogreen/features/home/details/presentation/widgets/add_to_cart_bottom_bar_widget.dart';
import 'package:gogreen/features/home/details/presentation/widgets/design_for_product_detail_info_widget.dart';
import 'package:gogreen/features/home/details/presentation/widgets/shimmer_product_detail_info_widget.dart';
import 'package:gogreen/features/home/offers/presentation/widget/product_detail_offers_widget.dart';

class ProductDetailsPage extends ConsumerWidget {
  final int productId;
  final String companyName;

  const ProductDetailsPage({
    super.key,
    required this.productId,
    required this.companyName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var controller = ref.watch(productDetailProvider(productId));

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            floating: false,
            delegate: AppbarSliverPersistentHeaderWidget(
              title: companyName.toString(),
              expandedHeight: 280.h,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 14.h),
                child: ProductDetailOffersWidget(id: productId),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: UIState(
              state: controller.viewState,
              loadingState: ShimmerProductDetailInfoWidget(),
              errorState: ErrorState.container(
                error: controller.errorModel,
              ),
              child: DesignForProductDetailInfoWidget(
                name: controller.data.name,
                unit: controller.data.unit.toString(),
                description: controller.data.description,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: UIState(
        state: controller.viewState,
        loadingState: const SizedBox(),
        errorState: const SizedBox(),
        child: AddToCartBottomBarWidget(
          productId: controller.data.id,
          company: controller.data.company,
          price: controller.data.price.toString(),
          onAdd: (qty) async {
            await ref.read(cartProvider.notifier).addOrUpdateCart(
                  product: CartProductModel.fromProductDetailModel(
                    controller.data,
                    qty,
                  ),
                  increment: true,
                );
            Navigator.pop(context);
            showFlashBarSuccess(
              context: context,
              message: 'Added to cart successfully',
            );

            return true;
          },
        ),
      ),
    );
  }
}
