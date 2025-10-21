import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/core/widget/rating_bar_widget.dart';
import 'package:gogreen/core/widget/shimmer_widget.dart';

class ShimmerForCommentsWidget extends StatelessWidget {
  const ShimmerForCommentsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 8,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(top: 18.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ShimmerWidget(
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2.5,
                      height: 16.h,
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(6.sp),
                      ),
                    ),
                  ),
                  const Spacer(),
                  ShimmerWidget(
                    child: RatingBarWidget(
                      evaluation: 4.5,
                      itemSize: 14.sp,
                      unratedColor: const Color(0xfffed9a3),
                    ),
                  ),
                  4.w.horizontalSpace,
                  ShimmerWidget(
                    child: CircleAvatar(
                      radius: 9.sp,
                    ),
                  ),
                ],
              ),
              8.h.verticalSpace,
              ShimmerWidget(
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: 12.h,
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(6.sp),
                  ),
                ),
              ),
              2.h.verticalSpace,
              ShimmerWidget(
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.8,
                  height: 12.h,
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(6.sp),
                  ),
                ),
              ),
              4.h.verticalSpace,
              Row(
                children: [
                  const ShimmerWidget(
                    child: Icon(
                      Icons.favorite_sharp,
                      size: 26,
                    ),
                  ),
                  6.w.horizontalSpace,
                  ShimmerWidget(
                    child: Container(
                      width: 30.w,
                      height: 10.h,
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(6.sp),
                      ),
                    ),
                  ),
                  12.w.horizontalSpace,
                  ShimmerWidget(
                    child: Container(
                      margin: EdgeInsets.only(top: 1.h),
                      width: 50.w,
                      height: 8.h,
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(6.sp),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
