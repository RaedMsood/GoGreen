import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/core/constants/app_images.dart';
import 'package:gogreen/core/theme/app_colors.dart';
import 'package:gogreen/core/widget/auto_size_text_widget.dart';
import 'buttons/back_button_widget.dart';

SliverAppBar appBarSliverWidget({
  required String title,
  required Widget child,
  required double expandedHeight,
  bool actions=false,
}) {
  return SliverAppBar(
    automaticallyImplyLeading: false,
    backgroundColor: AppColors.transparent,
    centerTitle: true,
    pinned: true,
    floating: false,
    expandedHeight: expandedHeight,
    toolbarHeight: 70.h,
    elevation: 0.0,
    leadingWidth: 60.w,
    title: AutoSizeTextWidget(
      text: title,
      colorText: Colors.white,
      fontSize: 15.sp,
      minFontSize: 15,
    ),
    leading: const BackButtonWidget(),
    actions:actions==true? [
      SizedBox(
        height: 20.h,
        width: 55.w,
      ),
    ]:[],
    flexibleSpace: Container(

      padding: EdgeInsets.zero,
      height: expandedHeight,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(18.r),
          bottomRight: Radius.circular(18.r),
        ),
        image: const DecorationImage(
          image: AssetImage(
            AppImages.topPattern,
          ),
          alignment: Alignment.topLeft,
        ),
      ),
      child: child,
    ),
  );
}
