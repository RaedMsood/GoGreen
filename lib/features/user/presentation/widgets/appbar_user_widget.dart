import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/core/theme/app_colors.dart';
import 'package:gogreen/core/widget/auto_size_text_widget.dart';
import 'package:gogreen/core/widget/buttons/back_button_widget.dart';


AppBar appBarUserWidget({
  required String title,
}) {
  return AppBar(
    backgroundColor: AppColors.primaryColor,
    toolbarHeight: 60.h,
    automaticallyImplyLeading: false,
    elevation: 0.0,
    leadingWidth: 65.w,
    centerTitle: true,
    leading: const BackButtonWidget(),
    title: AutoSizeTextWidget(
      text: title,
      colorText: Colors.white,
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      systemNavigationBarColor: AppColors.primarySwatch.shade100,
      systemNavigationBarDividerColor: AppColors.primarySwatch.shade100,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
}
