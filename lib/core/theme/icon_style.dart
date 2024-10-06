import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';


/// This class contains the style of the app icon.
class AppIconStyle {
  static BoxDecoration get decorationBackgroundColor => BoxDecoration(
        color: AppColors.secondarySwatch.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.w),
        // boxShadow: [
        //   BoxShadow(
        //     color: AppColors.dropShadow.withOpacity(0.1),
        //     offset: Offset(0, 4.w),
        //     blurRadius: 12.w,
        //   ),
        // ],
      );
}
