import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/core/constants/app_images.dart';
import 'package:gogreen/core/theme/app_colors.dart';
import 'package:gogreen/core/widget/auto_size_text_widget.dart';

class DesignForCitiesAndDistrictsNamesWidget extends StatelessWidget {
  final String name;
  final VoidCallback onTap;

  const DesignForCitiesAndDistrictsNamesWidget({
    super.key,
    required this.name,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: AppColors.primarySwatch.shade50.withOpacity(.6),
      highlightColor: AppColors.primarySwatch.shade50.withOpacity(.4),
      borderRadius: BorderRadius.circular(14.r),
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 22.w),
        margin: EdgeInsets.symmetric(vertical: 4.h),
        child: AutoSizeTextWidget(
          text: name.toString(),
          fontSize: 15.sp,
          textAlign: TextAlign.start,
        ),
      ),
    );
  }
}

class SearchResultsAreEmptyWidget extends StatelessWidget {
  const SearchResultsAreEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 14.h),
          child: Image.asset(
            AppImages.noData,
            height: 200.h,
          ),
        ),
        const AutoSizeTextWidget(text: "Search results are empty"),
      ],
    );
  }
}

