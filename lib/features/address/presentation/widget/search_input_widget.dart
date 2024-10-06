import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gogreen/core/constants/app_icons.dart';
import 'package:gogreen/core/theme/app_colors.dart';
import 'package:gogreen/core/widget/inputs/text_form_field.dart';

class SearchInputWidget extends StatelessWidget {
  TextEditingController search = TextEditingController();
  final ValueChanged onChanged;

  SearchInputWidget({
    super.key,
    required this.search,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18.sp),
        child: TextFormFieldWidget(
          controller: search,
          type: TextInputType.text,
          hintText: "Search",
          fillColor: AppColors.greySwatch.shade50,
          onChanged: onChanged,
          prefix: Padding(
            padding: EdgeInsets.symmetric(vertical: 14.h),
            child: SvgPicture.asset(
              AppIcons.search,
              height: 15.h,
              color: AppColors.greySwatch.shade500,
            ),
          ),
        ),
      ),
    );
  }
}
