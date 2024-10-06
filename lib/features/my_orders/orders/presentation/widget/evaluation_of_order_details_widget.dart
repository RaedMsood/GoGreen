import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/core/theme/theme.dart';
import 'package:gogreen/core/widget/auto_size_text_widget.dart';
import 'package:gogreen/core/helpers/navigateTo.dart';
import 'package:gogreen/core/widget/rating_bar_widget.dart';
import 'package:gogreen/features/my_orders/evaluation/presentation/pages/shimmer_for_evaluation_page.dart';

import 'card_design_for_order_details_widget.dart';

class EvaluationOfOrderDetailsWidget extends StatelessWidget {
  const EvaluationOfOrderDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CardDesignForOrderDetailsWidget(
      title: "Evaluation",
      icon: Icons.star_rounded,
      child: Padding(
        padding: EdgeInsets.only(left: 8.w, bottom: 4.h, top: 2.h),
        child: Row(
          children: [
            RatingBarWidget(
              evaluation: 4,
              length: 1,
              labeledColor: const Color(0xfffa9e1e),
              itemSize: 22,
            ),
            4.w.horizontalSpace,
            AutoSizeTextWidget(
              text: "4.8",
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
            ),
            8.w.horizontalSpace,
            GestureDetector(
              onTap: (){
                navigateTo(context, const ShimmerForEvaluationPage());
              },
              child: AutoSizeTextWidget(
                text: "(4.8k reviews)",
                fontSize: 9.4.sp,
                fontWeight: FontWeight.w400,
                colorText: fontColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
