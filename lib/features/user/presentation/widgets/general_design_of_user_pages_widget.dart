import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gogreen/core/constants/app_icons.dart';
import 'package:gogreen/core/constants/app_images.dart';
import 'package:gogreen/core/theme/app_colors.dart';

class GeneralDesignOfUserPagesWidget extends StatelessWidget {
  final Widget widget;

  const GeneralDesignOfUserPagesWidget({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.only(left: 14.w, right: 14.w, top: 24.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primaryColor,
            AppColors.primarySwatch.shade600.withOpacity(.99),
            AppColors.primarySwatch.shade400.withOpacity(.8),
            AppColors.primarySwatch.shade100.withOpacity(.99),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        image: const DecorationImage(
          image: AssetImage(
            AppImages.topPattern,
          ),
          alignment: Alignment.bottomLeft,
        ),
      ),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SvgPicture.asset(
              AppIcons.logo,
              height: 95.h,
            ),
            28.h.verticalSpace,
            widget,
          ],
        ),
      ),
    );
  }
}
