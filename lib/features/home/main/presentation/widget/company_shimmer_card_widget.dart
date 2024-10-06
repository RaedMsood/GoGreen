import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gogreen/core/constants/app_icons.dart';
import 'package:gogreen/core/widget/rating_bar_widget.dart';
import 'package:gogreen/core/widget/shimmer_widget.dart';

class CompanyShimmerCardWidget extends StatelessWidget {
  const CompanyShimmerCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal:  14.0.w),
      mainAxisSpacing: 16.r,
      crossAxisSpacing: 24.r,
      gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.all(8.sp),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.01),
                blurRadius: 2.r,
              ),
            ],
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  ShimmerPlaceholderWidget(
                    width: double.infinity,
                    height: 100.h,
                  ),
                  SvgPicture.asset(
                    AppIcons.logo,
                    height: 40.h,
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              ShimmerPlaceholderWidget(
                width: double.infinity,
                height: 17.r,
              ),
              6.h.verticalSpace,
              ShimmerWidget(
                child: RatingBarWidget(
                  evaluation: 5.0,
                ),
              ),
              6.h.verticalSpace,
              ShimmerPlaceholderWidget(
                width: 100.w,
                height: 12.r,
              ),
            ],
          ),
        );
      },
      itemCount: 8,
    );
  }
}
