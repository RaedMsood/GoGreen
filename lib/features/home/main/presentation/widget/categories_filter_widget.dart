import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gogreen/core/theme/app_colors.dart';
import 'package:gogreen/core/widget/auto_size_text_widget.dart';

class CategoriesFilterWidget extends StatelessWidget {
  final String title;
  final String icon;
  final bool isActive;
  final VoidCallback? onTap;

  const CategoriesFilterWidget({
    Key? key,
    required this.title,
    this.icon = '',
    this.isActive = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) onTap!();
      },
      child: Container(
        margin: EdgeInsetsDirectional.only(start: 14.w),
        padding: EdgeInsets.symmetric(
          horizontal: icon.isNotEmpty ? 12.w : 18.w,
        ),
        decoration: BoxDecoration(
          color: AppColors.greySwatch.shade100.withOpacity(.5),
          border: Border.all(
            color: isActive
                ? AppColors.primaryColor
                : AppColors.greySwatch.shade100.withOpacity(.2),
          ),
          borderRadius: BorderRadius.circular(9.r),
        ),
        child: Row(
          children: [
            if (icon.isNotEmpty)
              SvgPicture.asset(
                icon,
                height: 16.r,
                width: 16.r,
              ),
            if (icon.isNotEmpty) SizedBox(width: 8.w),
            AutoSizeTextWidget(
              text: title,
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
            ),
          ],
        ),
      ),
    );
  }

  static Widget secondary(
      {required String title,
      required bool isActive,
      required Null Function() onTap}) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) onTap!();
      },
      child: Container(
        margin: EdgeInsetsDirectional.only(start: 10.w),
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        decoration: BoxDecoration(
          color: isActive
              ? AppColors.primarySwatch.shade300.withOpacity(.25)
              : AppColors.greySwatch.shade100.withOpacity(.5),
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Row(
          children: [
            AutoSizeTextWidget(
              text: title,
              fontSize: 11.5.sp,
            ),
          ],
        ),
      ),
    );
  }
}
