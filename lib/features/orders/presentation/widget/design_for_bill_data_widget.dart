import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/Core/theme/app_colors.dart';
import 'package:gogreen/core/theme/theme.dart';
import 'package:gogreen/core/widget/auto_size_text_widget.dart';

class DesignForBillDataWidget extends StatelessWidget {
  final String title;
  final String title2;

  const DesignForBillDataWidget({
    super.key,
    required this.title,
    required this.title2,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(bottom: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 2.8,
            child: AutoSizeTextWidget(
              text: title,
              fontSize: 12.5.sp,
              minFontSize: 11,
            ),
          ),
          8.w.horizontalSpace,
          Expanded(
            child: AutoSizeTextWidget(
              text: title2,
              colorText: AppColors.primarySwatch.shade700,
              textAlign: TextAlign.right,
              fontSize: 10.5.sp,
              fontWeight: FontWeight.w700,

              minFontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
