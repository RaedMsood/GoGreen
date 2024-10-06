import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/core/theme/app_colors.dart';
import 'package:gogreen/core/widget/auto_size_text_widget.dart';
import 'package:gogreen/core/widget/buttons/default_button.dart';

class TotalAndConfirmOrderBottomBarWidget extends StatelessWidget {
  final String total;

  final bool? isLoading;
  final VoidCallback onPressed;

  const TotalAndConfirmOrderBottomBarWidget({
    super.key,
    required this.total,
    this.isLoading = false,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.09),
            blurRadius: 4.r,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: AppColors.greySwatch.shade50,
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AutoSizeTextWidget(
                  text: "Total",
                  fontSize: 12.6.sp,
                ),
                Flexible(
                  child: AutoSizeTextWidget(
                    text: "\$$total",
                    colorText: AppColors.brownColor,
                    fontSize: 11.2.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          10.h.verticalSpace,
          DefaultButtonWidget(
            text: "Confirm Order",
            textSize: 13.6.sp,
            isLoading: isLoading,
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }
}
