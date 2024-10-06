import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gogreen/core/constants/app_icons.dart';
import 'package:gogreen/core/theme/app_colors.dart';
import 'package:gogreen/core/widget/shimmer_widget.dart';

class NotificationShimmerCardWidget extends StatelessWidget {
  const NotificationShimmerCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.all(18.sp),
      itemCount: 8,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(bottom: 24.h),
          color: AppColors.whiteColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100.sp),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        ShimmerPlaceholderWidget(
                          width: 58.w,
                          height: 54.h,
                        ),
                        SvgPicture.asset(
                          AppIcons.logo,
                          height: 26.h,
                        ),
                      ],
                    ),
                  ),
                  12.w.horizontalSpace,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        4.h.verticalSpace,
                        ShimmerPlaceholderWidget(
                          width: 200.w,
                          height: 18.h,
                        ),
                        7.h.verticalSpace,
                        ShimmerPlaceholderWidget(
                          width: 120.w,
                          height: 15.h,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              10.h.verticalSpace,

              ShimmerPlaceholderWidget(
                width: 300.w,
                height: 14.h,
              ),
              4.h.verticalSpace,
              ShimmerPlaceholderWidget(
                width: 192.w,
                height: 14.h,
              ),
            ],
          ),
        );
      },
    );
  }
}
