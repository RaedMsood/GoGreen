import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gogreen/core/constants/app_icons.dart';
import 'package:gogreen/core/widget/appbar_sliver_persistent_header_widget.dart';
import 'package:gogreen/core/widget/shimmer_widget.dart';
import 'company_shimmer_card_for_order_details_widget.dart';
import 'order_details_shimmer_card_widget.dart';

class OrderDetailsShimmerWidget extends StatelessWidget {
  const OrderDetailsShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          pinned: true,
          floating: false,
          delegate: AppbarSliverPersistentHeaderWidget(
            title: "Order Details",
            expandedHeight: 234.h,
            child: const CompanyShimmerCardForOrderDetailsWidget(),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(14.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OrderDetailsShimmerCardWidget(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShimmerPlaceholderWidget(
                        height: 17.h,
                        width: 200.w,
                      ),
                      6.h.verticalSpace,
                      ShimmerPlaceholderWidget(
                        height: 14.h,
                        width: 120.w,
                      ),
                    ],
                  ),
                ),
                OrderDetailsShimmerCardWidget(
                  child: ShimmerPlaceholderWidget(
                    height: 17.h,
                    width: 200.w,
                  ),
                ),
                OrderDetailsShimmerCardWidget(
                  child: Row(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          ShimmerPlaceholderWidget(
                            height: 70.h,
                            width: 85.w,
                          ),
                          SvgPicture.asset(
                            AppIcons.logo,
                            height: 35.h,
                          ),
                        ],
                      ),
                      8.w.horizontalSpace,
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ShimmerPlaceholderWidget(
                              height: 17.h,
                              width: 180.w,
                            ),
                            4.h.verticalSpace,
                            ShimmerPlaceholderWidget(
                              height: 14.h,
                              width: 120.w,
                            ),
                            6.h.verticalSpace,
                            ShimmerPlaceholderWidget(
                              height: 14.h,
                              width: 90.w,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                OrderDetailsShimmerCardWidget(
                  child: Row(
                    children: [
                      ShimmerWidget(
                        child: Icon(
                          Icons.star_rounded,
                          size: 23.sp,
                        ),
                      ),
                      4.w.horizontalSpace,
                      ShimmerPlaceholderWidget(
                        height: 11.h,
                        width: 32.w,
                      ),
                      6.w.horizontalSpace,
                      ShimmerPlaceholderWidget(
                        height: 9.h,
                        width: 88.w,
                      ),
                    ],
                  ),
                ),
                OrderDetailsShimmerCardWidget(
                  child: Column(
                    children: [
                      Column(
                        children: List.generate(
                          5,
                          (index) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: 8.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: ShimmerPlaceholderWidget(
                                      height: 17.h,
                                    ),
                                  ),
                                  54.w.horizontalSpace,
                                  Expanded(
                                    child: ShimmerPlaceholderWidget(
                                      height: 17.h,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      ShimmerWidget(
                        child: Divider(
                          color: Colors.grey[300],
                          thickness: 0.6,
                        ),
                      ),
                      4.h.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: ShimmerPlaceholderWidget(
                              height: 17.h,
                            ),
                          ),
                          54.w.horizontalSpace,
                          Expanded(
                            child: ShimmerPlaceholderWidget(
                              height: 17.h,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
