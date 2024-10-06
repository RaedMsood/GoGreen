import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/core/widget/auto_size_text_widget.dart';

class NameAndColorOfTheProductStatisticsWidget extends StatelessWidget {
  final String title;
  final Color color;

  const NameAndColorOfTheProductStatisticsWidget({
    super.key,
    required this.title,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 24.w,
            height: 8.h,
            color: color,
          ),
          SizedBox(width: 10.w),
          Flexible(
              child: AutoSizeTextWidget(
            text: title,
            fontSize: 12.sp,
            maxLines: 3,
          )),
        ],
      ),
    );
  }
}
