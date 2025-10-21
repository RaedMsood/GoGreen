import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/core/widget/appbar_sliver_persistent_header_widget.dart';
import 'package:gogreen/core/widget/auto_size_text_widget.dart';
import 'package:gogreen/core/widget/rating_bar_widget.dart';
import 'package:gogreen/core/widget/shimmer_widget.dart';


import '../../../../orders/presentation/widget/company_shimmer_card_for_order_details_widget.dart';
import 'shimmer_for_comments_widget.dart';
import 'shimmer_for_evaluation_linear_progress_indicator_widget.dart';

class ShimmerForEvaluationWidget extends StatelessWidget {
  const ShimmerForEvaluationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          pinned: true,
          floating: false,
          delegate: AppbarSliverPersistentHeaderWidget(
            title: "Evaluation",
            expandedHeight: 234.h,
            child: const CompanyShimmerCardForOrderDetailsWidget(),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.only(left: 14.w, right: 14.w, bottom: 14.h),
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Column(
                      children: [
                        ShimmerWidget(
                          child: AutoSizeTextWidget(
                            text: "0.0",
                            fontSize: 30.sp,
                            maxFontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        8.h.verticalSpace,
                        ShimmerWidget(
                          child: RatingBarWidget(
                            evaluation: 5.0,
                            itemSize: 22.sp,
                          ),
                        ),
                        6.h.verticalSpace,
                        ShimmerWidget(
                          child: Container(
                            width: 84.w,
                            height: 14.h,
                            decoration: BoxDecoration(
                              color: Colors.green.shade50,
                              borderRadius: BorderRadius.circular(4.sp),
                            ),
                          ),
                        ),
                      ],
                    ),

                    /// Class Shimmer For Evaluation Linear Progress Indicator
                    const ShimmerForEvaluationLinearProgressIndicatorWidget(),
                  ],
                ),

                /// Class Shimmer For Designing Evaluation Comments
                const ShimmerForCommentsWidget(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
