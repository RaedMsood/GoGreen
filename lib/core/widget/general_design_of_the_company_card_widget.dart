import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/core/theme/app_colors.dart';
import 'package:gogreen/core/widget/auto_size_text_widget.dart';
import 'package:gogreen/core/widget/rating_bar_widget.dart';
import 'gradient_widget.dart';
import 'online_images_widget.dart';

class GeneralDesignOfTheCompanyCardWidget extends StatelessWidget {
  final String image;
  final String name;
  final String address;
  final double evaluation;

  const GeneralDesignOfTheCompanyCardWidget({
    super.key,
    required this.image,
    required this.name,
    required this.address,
    required this.evaluation,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.sp),
      margin: EdgeInsets.all(14.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.sp),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          AutoSizeTextWidget(
            text: "The Company",
            fontSize: 11.sp,
            colorText: AppColors.greySwatch.shade600,
          ),
          8.h.verticalSpace,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OnlineImagesWidget(
                imageUrl: image ,
                size: Size(86.w, 80.h),
                fit: BoxFit.contain,
                externalLink: true,
                child: const Stack(
                  clipBehavior: Clip.none,
                  children: [
                    /// Class Gradient
                    GradientWidget(),
                  ],
                ),
              ),
              10.w.horizontalSpace,
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeTextWidget(
                      text:name,
                      fontSize: 12.sp,
                      maxLines: 3,
                      minFontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                    8.h.verticalSpace,
                    RatingBarWidget(
                      evaluation: evaluation,
                      labeledColor: const Color(0xfff2c288),
                    ),
                    8.h.verticalSpace,
                    AutoSizeTextWidget(
                      text: address,
                      fontSize: 9.5.sp,
                      maxLines: 3,
                      colorText: AppColors.greySwatch.shade600,
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
