import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gogreen/core/constants/app_icons.dart';
import 'package:gogreen/core/widget/shimmer_widget.dart';

class MyOrderShimmerCardWidget extends StatelessWidget {
  const MyOrderShimmerCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.all(14.sp),
      itemBuilder: (context, index) {
        return    Container(
          padding: EdgeInsets.all(8.sp),
          margin: EdgeInsets.only(bottom: 13.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.sp),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  ShimmerPlaceholderWidget(
                    width: 85.w,
                    height: 15.h,
                  ),
                  8.w.horizontalSpace,
                  Flexible(
                    child: ShimmerPlaceholderWidget(
                      height: 15.h,
                      width: 140.w,
                    ),
                  ),
                ],
              ),
              10.h.verticalSpace,
              Row(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      ShimmerPlaceholderWidget(
                        height: 70.h,
                        width: 85.w,
                      ),
                      SvgPicture.asset(
                        AppIcons.logo,
                        height: 35.h,
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
                          width: 180.w,
                        ),
                        6.h.verticalSpace,
                        ShimmerPlaceholderWidget(
                          height: 12.h,
                          width: 90.w,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              5.h.verticalSpace,

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShimmerPlaceholderWidget(
                    height: 15.h,
                    width: 85.w,
                  ),
                  ShimmerPlaceholderWidget(
                    height: 28.h,
                    width: 140.w,
                  ),

                ],
              ),
            ],
          ),
        ); 
      },
    itemCount: 8,
    );
  }
}
