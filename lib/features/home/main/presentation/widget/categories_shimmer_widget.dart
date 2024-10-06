import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/core/widget/shimmer_widget.dart';

class CategoriesShimmerWidget extends StatelessWidget {
  const CategoriesShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding:
          EdgeInsets.only(left: 14.w, right: 14.w, bottom: 14.h, top: 30.h),
      scrollDirection: Axis.horizontal,
      children: [
        ShimmerPlaceholderWidget(
          width: 120.h,
        ),
        10.w.horizontalSpace,
        ShimmerPlaceholderWidget(
          width: 120.h,
        ),
        10.w.horizontalSpace,
        ShimmerPlaceholderWidget(
          width: 120.h,
        ),
        SizedBox(width: 21.5.w)
      ],
    );
  }
}
