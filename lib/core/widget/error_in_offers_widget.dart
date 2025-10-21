import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/core/theme/app_colors.dart';
import 'package:gogreen/core/widget/online_images_widget.dart';

class ErrorInOffersWidget extends StatelessWidget {
  const ErrorInOffersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160.h,
      margin: EdgeInsets.symmetric(horizontal: 14.w),
      decoration: BoxDecoration(
        color: AppColors.greySwatch.shade50,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child:  const OnlineImagesWidget(
        imageUrl:  "",
        externalLink: true,
        fit: BoxFit.contain,
      ),
    );
  }
}

