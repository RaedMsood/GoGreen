import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/core/theme/app_colors.dart';
import 'package:gogreen/core/widget/auto_size_text_widget.dart';
import 'package:gogreen/core/helpers/navigateTo.dart';
import 'package:gogreen/core/widget/rating_bar_widget.dart';
import 'package:gogreen/features/home/evaluation/presentation/pages/evaluation_page.dart';
import 'card_design_for_order_details_widget.dart';

class EvaluationOfOrderDetailsWidget extends StatelessWidget {
  final int id;
  final String companyImage;
  final String companyName;
  final String companyAddress;
  final double evaluation;

  const EvaluationOfOrderDetailsWidget({
    super.key,
    required this.id,
    required this.companyImage,
    required this.companyName,
    required this.companyAddress,
    required this.evaluation,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigateTo(
          context,
          EvaluationPage(
            id: id,
            companyImage: companyImage,
            companyName: companyName,
            companyAddress: companyAddress,
            addARating: true,
          ),
        );
      },
      child: CardDesignForOrderDetailsWidget(
        title: "Evaluation",
        icon: Icons.star_rounded,
        child: Padding(
          padding: EdgeInsets.only(left: 8.w, bottom: 4.h, top: 2.h),
          child: Row(
            children: [
                RatingBarWidget(
                evaluation: evaluation,
                length: 1,
                labeledColor:  Color(0xfffa9e1e),
                itemSize: 22,
              ),
              4.w.horizontalSpace,
              AutoSizeTextWidget(
                text: evaluation.toString(),
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
              ),
              8.w.horizontalSpace,
              AutoSizeTextWidget(
                text: "(4.8k reviews)",
                fontSize: 9.4.sp,
                fontWeight: FontWeight.w400,
                colorText: AppColors.greySwatch.shade600,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
