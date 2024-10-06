import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/core/theme/app_colors.dart';
import 'package:gogreen/core/widget/auto_size_text_widget.dart';

class DesignForProductDetailInfoWidget extends StatelessWidget {
  final String name;
  final String description;
  final String unit;

  const DesignForProductDetailInfoWidget({
    super.key,
    required this.name,
    required this.description,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(14.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          8.h.verticalSpace,
          AutoSizeTextWidget(
            text: name.toString(),
            maxLines: 6,
            fontSize: 14.5.sp,
            fontWeight: FontWeight.bold,
          ),
          4.h.verticalSpace,
          AutoSizeTextWidget(
            text: unit.toString(),
            fontSize: 10.5.sp,
            colorText: AppColors.greySwatch.shade600,
            maxLines: 3,
          ),
          12.h.verticalSpace,
          AutoSizeTextWidget(
            text: "about product",
            fontSize: 12.5.sp,
            colorText: AppColors.primaryColor,
          ),
          6.h.verticalSpace,
          AutoSizeTextWidget(
            text: description.toString(),
            fontSize: 10.5.sp,
            colorText: AppColors.greySwatch.shade600,
            maxLines: 6,
          ),
        ],
      ),
    );
  }
}
