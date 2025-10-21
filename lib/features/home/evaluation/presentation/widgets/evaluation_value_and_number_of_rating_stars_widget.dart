import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/core/theme/app_colors.dart';
import 'package:gogreen/core/widget/auto_size_text_widget.dart';
import 'package:gogreen/core/widget/rating_bar_widget.dart';

class EvaluationValueAndNumberOfRatingStarsWidget extends StatelessWidget {
  final double rates;
  final double total;

  const EvaluationValueAndNumberOfRatingStarsWidget(
      {super.key, required this.rates, required this.total});

  @override
  Widget build(BuildContext context) {
    double tempRates = (rates * 10).truncate() / 10;

    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Column(
          children: [
            AutoSizeTextWidget(
              text: tempRates.toString(),
              fontSize: 30.sp,
              maxFontSize: 40,
              fontWeight: FontWeight.bold,
            ),
            8.h.verticalSpace,
            RatingBarWidget(
              evaluation: tempRates,
              itemSize: 22.sp,
              unratedColor: const Color(0xfffed9a3),
            ),
            6.h.verticalSpace,
            AutoSizeTextWidget(
              text:
                  "(${total.toString()}${total >= 1000000 ? "m" : total >= 1000 ? "k" : ""} reviews)",
              fontSize: 11.6.sp,
              colorText: AppColors.greySwatch.shade800,

            ),
          ],
        ),
      ],
    );
  }
}
