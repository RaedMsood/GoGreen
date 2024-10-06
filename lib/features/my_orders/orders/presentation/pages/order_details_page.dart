import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/Core/theme/app_colors.dart';
import 'package:gogreen/core/extension/string.dart';
import 'package:gogreen/core/states/error.state.dart';
import 'package:gogreen/core/states/ui.state.dart';
import 'package:gogreen/core/states/view.state.dart';
import 'package:gogreen/core/widget/appbar_sliver_persistent_header_widget.dart';
import 'package:gogreen/core/widget/appbar_widget.dart';
import 'package:gogreen/core/widget/auto_size_text_widget.dart';
import 'package:gogreen/core/widget/general_design_of_the_company_card_widget.dart';
import 'package:gogreen/features/my_orders/orders/presentation/riverpod/order_riverpod.dart';
import 'package:gogreen/features/my_orders/orders/presentation/widget/bill_of_order_details_widget.dart';
import 'package:gogreen/features/my_orders/orders/presentation/widget/card_design_for_order_details_widget.dart';
import 'package:gogreen/features/my_orders/orders/presentation/widget/design_of_order_requests_widget.dart';
import 'package:gogreen/features/my_orders/orders/presentation/widget/evaluation_of_order_details_widget.dart';
import 'package:gogreen/features/my_orders/orders/presentation/widget/order_details_shimmer_widget.dart';

class OrderDetailsPage extends ConsumerWidget {
  final int id;

  const OrderDetailsPage({super.key, required this.id});

  @override
  Widget build(BuildContext context, ref) {
    var controller = ref.watch(getOrderDetailProvider(id));

    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: controller.viewState == ViewState.failure
          ? AppBarWidget(title: "Order Details")
          : null,
      body: UIState(
        state: controller.viewState,
        loadingState: const OrderDetailsShimmerWidget(),
        errorState: Center(
          child: ErrorState.container(
            error: controller.errorModel,
          ),
        ),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              floating: false,
              delegate: AppbarSliverPersistentHeaderWidget(
                title: "Order Details",
                expandedHeight: 234.h,
                child: GeneralDesignOfTheCompanyCardWidget(
                  image: controller.data.company.image.toString(),
                  name: controller.data.company.name.toString(),
                  evaluation: double.parse(controller.data.company.rates.toString()),
                  address: controller.data.company.address.toString(),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(14.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CardDesignForOrderDetailsWidget(
                      title: "Order address",
                      icon: Icons.location_on_rounded,
                      child: Padding(
                        padding: EdgeInsets.only(left: 22.w),
                        child: AutoSizeTextWidget(
                          text: controller.data.address.address.toString(),
                          fontSize: 12.sp,
                          maxLines: 3,
                          colorText: Colors.black87,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    CardDesignForOrderDetailsWidget(
                      title: "Means of transportation",
                      icon: Icons.local_shipping_sharp,
                      child: Padding(
                        padding:
                            EdgeInsets.only(left: 22.w, bottom: 4.h, top: 4.h),
                        child: AutoSizeTextWidget(
                          text: controller.data.vehicleType.name,
                          colorText: Colors.black87,
                          fontWeight: FontWeight.w700,
                          fontSize: 12.sp,
                          maxLines: 2,
                        ),
                      ),
                    ),
                    CardDesignForOrderDetailsWidget(
                      title: "Order",
                      icon: Icons.text_snippet,
                      child: Column(
                        children: [
                          ...controller.data.products.map((e) {
                            return DesignOfOrderRequestsWidget(
                              product: e,
                            );
                          }),
                        ],
                      ),
                    ),
                    const EvaluationOfOrderDetailsWidget(),
                    BillOfOrderDetailsWidget(
                      orderStatus: controller.data.status.name == 'Pending'
                          ? 'Being processed'
                          : 'successfully',
                      orderNumber:
                          "#${controller.data.transactionId.toString()}",
                      theDate: dayHour(controller.data.date),
                      priceOfProducts:
                          "\$${controller.data.productsPrice.toString()}",
                      deliveryPrice:
                          "\$${controller.data.deliveryPrice.toString()}",
                      totalSummation: "\$${controller.data.total.toString()}",
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
