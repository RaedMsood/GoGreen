import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gogreen/core/constants/app_icons.dart';
import 'package:gogreen/core/theme/app_colors.dart';
import 'package:gogreen/core/widget/shimmer_widget.dart';

class ShimmerToConfirmOrderWidget extends StatelessWidget {
  const ShimmerToConfirmOrderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        4.h.verticalSpace,

        Column(
          children: List.generate(
            3,
            (index) => Container(
              padding: EdgeInsets.all(8.sp),
              margin: EdgeInsets.only(bottom: 11.h),
              decoration: BoxDecoration(
                color: AppColors.greySwatch.shade50,
                borderRadius: BorderRadius.circular(10.sp),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      ShimmerPlaceholderWidget(
                        height: 47.h,
                        width: 66.w,
                      ),
                      SvgPicture.asset(
                        AppIcons.logo,
                        height: 24.h,
                      ),
                    ],
                  ),
                  14.w.horizontalSpace,
                  Flexible(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 1.4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ShimmerPlaceholderWidget(
                            width: 175.w,
                            height: 17.h,
                          ),
                          6.h.verticalSpace,
                          ShimmerPlaceholderWidget(
                            height: 14.h,
                            width: 120.w,
                          ),
                        ],
                      ),
                    ),
                  ),
                  ShimmerWidget(
                    child: SizedBox(
                      width: 24.5.w,
                      child: const Icon(
                        Icons.circle,
                        color: Color(0xffe4eae8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        4.h.verticalSpace,

        ShimmerPlaceholderWidget(
          height: 120.h,
          width: double.infinity,
        ),
        14.h.verticalSpace,

        ShimmerPlaceholderWidget(
          height: 40.h,
          width: double.infinity,
        ),
      ],
    );
  }
}

class ShimmerForDeliveryInformationWidget extends StatelessWidget {
  const ShimmerForDeliveryInformationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShimmerPlaceholderWidget(
          height: 20.h,
          width: 140.w,
        ),
        8.h.verticalSpace,
        ShimmerPlaceholderWidget(
          height: 38.h,
          width: double.infinity,
        ),
        10.h.verticalSpace,
        ShimmerPlaceholderWidget(
          height: 38.h,
          width: double.infinity,
        ),
        4.h.verticalSpace,
      ],
    );
  }
}
