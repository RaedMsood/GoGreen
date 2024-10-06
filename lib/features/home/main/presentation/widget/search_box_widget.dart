import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gogreen/core/constants/app_icons.dart';
import 'package:gogreen/core/theme/app_colors.dart';
import 'package:gogreen/core/widget/auto_size_text_widget.dart';

class SearchBoxWidget extends StatelessWidget {
  final double height;
  final double width;

  const SearchBoxWidget({
    super.key,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8.sp)),
      child: Row(
        children: [
          8.w.horizontalSpace,
          Flexible(
            child: SvgPicture.asset(
              AppIcons.search,
              height: 17.h,
              width: 17.w,
            ),
          ),
          6.w.horizontalSpace,
          Flexible(
            child: AutoSizeTextWidget(
              text: "Search for",
              colorText: AppColors.greySwatch.shade400,
              fontSize: 11.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
