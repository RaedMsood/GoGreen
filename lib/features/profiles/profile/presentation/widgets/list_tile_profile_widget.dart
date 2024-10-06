import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gogreen/core/theme/app_colors.dart';
import 'package:gogreen/core/widget/auto_size_text_widget.dart';

class ListTileProfileWidget extends StatelessWidget {
  final String title;
  final String icon;
  final Function()? onTap;
  final Color? titleColor;
  final Color? iconColor;
  final double? iconHeight;
  final double? paddingIconLeft;

  const ListTileProfileWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.titleColor,
    this.iconColor,
    this.iconHeight,
    this.paddingIconLeft,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 14.sp),
      alignment: Alignment.center,
      child: ListTile(
        onTap: onTap,
        leading: Padding(
          padding: EdgeInsets.only(left: paddingIconLeft ?? 0, right: 12.w),
          child: SvgPicture.asset(
            icon,
            height: iconHeight ?? 19.h,
            color: iconColor ?? AppColors.greySwatch.shade600,
          ),
        ),
        title: AutoSizeTextWidget(
          text: title,
          fontSize: 13.4.sp,
          colorText: titleColor ?? AppColors.greySwatch.shade600,
          maxFontSize: 25,
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: AppColors.greySwatch.shade600,
          size: 14.sp,
        ),
        titleAlignment: ListTileTitleAlignment.center,
        dense: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.sp),
        ),
        tileColor: AppColors.greySwatch.shade50,
        horizontalTitleGap: 0,
        contentPadding: EdgeInsets.symmetric(vertical: 2.5.h, horizontal: 12.w),
      ),
    );
  }
}
