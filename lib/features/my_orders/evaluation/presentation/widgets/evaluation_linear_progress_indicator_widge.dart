import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/core/widget/auto_size_text_widget.dart';

class EvaluationLinearProgressIndicatorWidget extends StatelessWidget {
  final int numberingLinearProgressIndicator;

  const EvaluationLinearProgressIndicatorWidget({
    super.key,
    required this.numberingLinearProgressIndicator,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 0.5.w,
          height: 24.h,
          color: const Color(0xffe0e0e0),
          margin: EdgeInsets.only(right: 14.w, left: 8.5.w),
        ),
        AutoSizeTextWidget(
          text: numberingLinearProgressIndicator.toString(),
          fontSize: 11.sp,
          fontWeight: FontWeight.w500,
        ),
        6.w.horizontalSpace,
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4.sp),
            child: const LinearProgressIndicator(
              value: 0.80,
              valueColor: AlwaysStoppedAnimation(Color(0xff31c060)),
              minHeight: 5.5,
              backgroundColor: Color(0xffe0e0e0),
            ),
          ),
        ),
        6.w.horizontalSpace,
        AutoSizeTextWidget(
          text: "% 80",
          fontSize: 10.sp,
        ),
      ],
    );
  }
}
