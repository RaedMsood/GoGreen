import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gogreen/core/theme/app_colors.dart';
import 'package:gogreen/core/widget/shimmer_widget.dart';
import 'package:gogreen/core/constants/app_icons.dart';

class ProductShimmerCardWidget extends ConsumerWidget {
  const ProductShimmerCardWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: 14.0.w),
      itemCount: 8,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(bottom: 14.h),
          padding: EdgeInsetsDirectional.all(8.sp),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(8.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.04),
                blurRadius: 1.r,
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  ShimmerPlaceholderWidget(
                    height: 90.h,
                    width: 100.w,
                  ),
                  SvgPicture.asset(
                    AppIcons.logo,
                    height: 50.h,
                  ),
                ],
              ),
              8.w.horizontalSpace,
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ShimmerPlaceholderWidget(
                      width: 180.w,
                      height: 17.h,
                    ),
                    5.h.verticalSpace,
                    ShimmerPlaceholderWidget(
                      height: 15.h,
                      width: 140.w,
                    ),
                    5.h.verticalSpace,
                    ShimmerPlaceholderWidget(
                      height: 14.h,
                      width: 100.w,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        ShimmerPlaceholderWidget(
                          height: 30.h,
                          width: 30.w,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
