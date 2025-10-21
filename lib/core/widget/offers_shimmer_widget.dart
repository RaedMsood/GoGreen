import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gogreen/core/constants/app_icons.dart';
import 'package:gogreen/core/theme/app_colors.dart';
import 'package:gogreen/core/widget/shimmer_widget.dart';

class OffersShimmerWidget extends StatelessWidget {
  const OffersShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 14.w),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child:   Stack(
        alignment: Alignment.center,
        children: [
          ShimmerPlaceholderWidget(
            width: double.infinity,
             height: 200.h,
          ),
          SvgPicture.asset(
            AppIcons.logo,
            height: 60.h,
          ),
        ],
      ),
    );
  }
}

