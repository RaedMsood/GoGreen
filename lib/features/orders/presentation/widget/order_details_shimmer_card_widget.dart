import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/core/theme/app_colors.dart';
import 'package:gogreen/core/widget/shimmer_widget.dart';

class OrderDetailsShimmerCardWidget extends StatelessWidget {
  final Widget child;

  const OrderDetailsShimmerCardWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 18.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.sp),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.04),
            blurRadius: 1.r,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerWidget(
            child: Container(
              width: double.infinity,
              height: 26.h,
              padding: EdgeInsets.all(8.sp),
              decoration: BoxDecoration(
                color: AppColors.primarySwatch.shade300.withOpacity(.8),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(
                    14.sp,
                  ),
                  topRight: Radius.circular(14.sp),
                ),
              ),
            ),
          ),

          /// Child
          Padding(
            padding: EdgeInsets.all(8.sp),
            child: child,
          ),
        ],
      ),
    );
  }
}