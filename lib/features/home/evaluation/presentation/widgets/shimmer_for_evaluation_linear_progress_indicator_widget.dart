import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/core/widget/auto_size_text_widget.dart';
import 'package:gogreen/core/widget/shimmer_widget.dart';

class ShimmerForEvaluationLinearProgressIndicatorWidget
    extends StatelessWidget {
  const ShimmerForEvaluationLinearProgressIndicatorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    int numberingLinearProgressIndicator = 6;
    return Expanded(
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Row(
            children: [
              Container(
                width: 0.5.w,
                height: 24.h,
                color: Colors.green.shade100,
                margin: EdgeInsets.only(right: 14.w, left: 8.5.w),
              ),
              ShimmerWidget(
                baseColor: Colors.green.shade100,
                child: AutoSizeTextWidget(
                  text: (numberingLinearProgressIndicator -= 1).toString(),
                  fontSize: 11.sp,
                ),
              ),
              6.w.horizontalSpace,
              Expanded(
                child: ShimmerWidget(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4.sp),
                    child: const LinearProgressIndicator(
                      minHeight: 5.5,
                    ),
                  ),
                ),
              ),
              6.w.horizontalSpace,
              ShimmerWidget(
                baseColor: Colors.green.shade100,
                child: AutoSizeTextWidget(
                  text: "0.0%",
                  fontSize: 10.sp,
                ),
              ),
            ],
          );
        },
        separatorBuilder: (context, index) => const SizedBox(),
      ),
    );
  }
}
