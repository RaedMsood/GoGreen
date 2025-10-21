import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/core/widget/auto_size_text_widget.dart';

class EvaluationLinearProgressIndicatorWidget extends StatelessWidget {
  final int numberingLinearProgressIndicator;
  final double value;

  const EvaluationLinearProgressIndicatorWidget({
    super.key,
    required this.numberingLinearProgressIndicator,
    required this.value,

  });

  @override
  Widget build(BuildContext context) {
    var percentageValue= value * 100;
    return Row(
      children: [
        Container(
          width: 0.5.w,
          height: 24.h,
          color: const Color(0xffe0e0e0),
          margin: EdgeInsets.only(right: 14.w, left: 8.5.w),
        ),
        SizedBox(
          width: 8.w,
          child: AutoSizeTextWidget(
            text: numberingLinearProgressIndicator.toString(),
            fontSize: 11.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        6.w.horizontalSpace,
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4.sp),
            child:  LinearProgressIndicator(
               value: value,
              valueColor: const AlwaysStoppedAnimation(Color(0xff31c060)),
              minHeight: 5.5,
              backgroundColor: const Color(0xffe0e0e0),
            ),
          ),
        ),
        4.w.horizontalSpace,
        SizedBox(
          width: 34.w,
          child: AutoSizeTextWidget(
            text: " ${(percentageValue * 10).truncate() /10}%",
            fontSize: 10.sp,
            minFontSize: 4,
          ),
        ),
      ],
    );
  }
}
