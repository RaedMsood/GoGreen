import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/core/widget/shimmer_widget.dart';

class ShimmerProductDetailInfoWidget extends StatelessWidget {
  const ShimmerProductDetailInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(14.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          SizedBox(height: 8.h),
          ShimmerPlaceholderWidget(width: 200.w, height: 20.h),
          SizedBox(height: 8.h),
          ShimmerPlaceholderWidget(width: 80.w, height: 14.h),
          SizedBox(height: 8.h),
          ShimmerPlaceholderWidget(width: 66.w, height: 14.h),
          SizedBox(height: 8.h),
          ShimmerPlaceholderWidget(width: 300.w, height: 18.h),
          SizedBox(height: 4.h),
          ShimmerPlaceholderWidget(width: 220.w, height: 18.h),
          SizedBox(height: 4.h),
          ShimmerPlaceholderWidget(width: 180.w, height: 18.h),
          SizedBox(height: 4.h),
          ShimmerPlaceholderWidget(width: 300.w, height: 18.h),
          SizedBox(height: 4.h),
          ShimmerPlaceholderWidget(width: 220.w, height: 18.h),
          SizedBox(height: 4.h),
          ShimmerPlaceholderWidget(width: 180.w, height: 18.h),
        ],
      ),
    );
  }
}
