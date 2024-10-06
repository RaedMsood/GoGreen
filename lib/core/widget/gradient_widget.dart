import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/core/theme/app_colors.dart';

class GradientWidget extends StatelessWidget {
  const GradientWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        gradient: LinearGradient(
          colors: [
            AppColors.primaryColor.withOpacity(.84),
            AppColors.primaryColor.withOpacity(.54),
            AppColors.primarySwatch.shade700.withOpacity(.26),
            AppColors.primarySwatch.shade500.withOpacity(.1),

             AppColors.primarySwatch.shade500.withOpacity(.0),
            AppColors.primarySwatch.shade400.withOpacity(.0),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }
}

