import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gogreen/core/constants/app_icons.dart';
import 'package:gogreen/core/widget/rating_bar_widget.dart';
import 'package:gogreen/core/widget/shimmer_widget.dart';

class CompanyShimmerCardForOrderDetailsWidget extends StatelessWidget {
  const CompanyShimmerCardForOrderDetailsWidget({super.key});

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
          ShimmerPlaceholderWidget(
            height: 16.h,
            width: 87.w,
          ),
          8.h.verticalSpace,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  ShimmerPlaceholderWidget(
                    height: 78.h,
                    width: 86.w,
                  ),
                  SvgPicture.asset(
                    AppIcons.logo,
                    height: 40.h,
                  ),
                ],
              ),
              10.w.horizontalSpace,
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerPlaceholderWidget(
                      height: 20.h,
                      width: 185.w,
                    ),
                    8.h.verticalSpace,
                    ShimmerWidget(
                      child: RatingBarWidget(
                        evaluation: 5,
                        itemSize: 16.sp,
                      ),
                    ),
                    8.h.verticalSpace,
                    ShimmerPlaceholderWidget(
                      height: 14.h,
                      width: 120.w,
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
