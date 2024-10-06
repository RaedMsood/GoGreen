import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/core/widget/auto_size_text_widget.dart';
import 'package:gogreen/core/widget/rating_bar_widget.dart';

class EvaluationValueAndNumberOfRatingStarsWidget extends StatelessWidget {
  const EvaluationValueAndNumberOfRatingStarsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Column(
          children: [
            AutoSizeTextWidget(
              text: "4.8",
              fontSize: 29.sp,
              maxFontSize: 40,
              fontWeight: FontWeight.bold,
            ),
            8.h.verticalSpace,
            RatingBarWidget(
              evaluation: 4.5,
              itemSize: 21.sp,
              unratedColor: const Color(0xfffed9a3),
            ),
            6.h.verticalSpace,
            AutoSizeTextWidget(
              text: "(4.8k reviews)",
              fontSize: 11.sp,
              colorText: Colors.black54,
            ),
          ],
        ),

      ],
    );
  }
}
