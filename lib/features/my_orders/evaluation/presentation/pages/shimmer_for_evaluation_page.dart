import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/core/widget/appbar_widget.dart';
import 'package:gogreen/core/widget/auto_size_text_widget.dart';
import 'package:gogreen/core/helpers/navigateTo.dart';
import 'package:gogreen/core/widget/rating_bar_widget.dart';
import 'package:gogreen/core/widget/shimmer_widget.dart';
import 'package:gogreen/features/my_orders/evaluation/presentation/widgets/shimmer_for_designing_evaluation_comments_widget.dart';
import 'package:gogreen/features/my_orders/evaluation/presentation/widgets/shimmer_for_evaluation_linear_progress_indicator_widge.dart';

import 'evaluation_page.dart';

class ShimmerForEvaluationPage extends StatefulWidget {
  const ShimmerForEvaluationPage({super.key});

  @override
  State<ShimmerForEvaluationPage> createState() =>
      _ShimmerForEvaluationPageState();
}

class _ShimmerForEvaluationPageState extends State<ShimmerForEvaluationPage> {
  su() {
    Future.delayed(const Duration(seconds: 6)).then((value) {
      return navigateTo(context, const EvaluationPage());
    });
  }

  @override
  void initState() {
    su();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: "Evaluation",
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(14.sp),
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
                        fontSize: 29.sp,
                        maxFontSize: 40,
                      ),
                    ),
                    8.h.verticalSpace,
                    ShimmerWidget(
                      child: RatingBarWidget(
                        evaluation: 5.0,
                        itemSize: 21.sp,
                      ),
                    ),
                    6.h.verticalSpace,
                    ShimmerWidget(
                      child: Container(
                        width: 80.w,
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
                ShimmerForEvaluationLinearProgressIndicatorWidget(),
              ],
            ),
            18.h.verticalSpace,

            /// Class Shimmer For Designing Evaluation Comments
            const ShimmerForDesigningEvaluationCommentsWidget(),
          ],
        ),
      ),
    );
  }
}
