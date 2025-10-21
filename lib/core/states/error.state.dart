import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/core/theme/app_colors.dart';
import 'package:gogreen/core/theme/text_style.dart';

import '../network/errors/error.model.wings.dart';

class ErrorState extends StatelessWidget {
  final ErrorModel error;

  const ErrorState({
    super.key,
    required this.error,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          error.icon,
          width: 260.w,
          height: 260.h,
        ),
        SizedBox(height: 8.h),
        Text(
          error.message,
          style: AppTextStyle.bold16.copyWith(
            color: AppColors.greySwatch.shade800,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 4.h),
        Text(
          error.desc,
          style: AppTextStyle.regular14.copyWith(
            color: AppColors.greySwatch.shade600,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  //and another build method for the error state

  static container(
      {required ErrorModel error,
      double? height,
      double? verticalPadding,
      double? horizontalMargin}) {
    //warp the error state in a container
    return Container(
      height: height,
      width: 1.sw,
      margin: EdgeInsets.symmetric(horizontal: horizontalMargin ?? 16.w)
          .copyWith(bottom: 16.h),
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: verticalPadding ?? 100.h,
      ),
      child: ErrorState(error: error),
    );
  }
}
