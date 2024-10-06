import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/core/theme/app_colors.dart';
import 'package:gogreen/core/widget/auto_size_text_widget.dart';

/// Success ///
void showFlashBarSuccess({
  required BuildContext context,
  required String message,
}) {
  Flushbar(
    duration: const Duration(seconds: 3),
    message: message,
    messageColor: Colors.white,
    messageSize: 13.sp,
    margin: EdgeInsets.symmetric(horizontal: 40.w, vertical: 18.h),
    padding: EdgeInsets.all(14.sp),
    backgroundColor: AppColors.successSwatch.shade800.withOpacity(.9),
    borderRadius: BorderRadius.circular(30.sp),
    flushbarPosition: FlushbarPosition.TOP,
    flushbarStyle: FlushbarStyle.FLOATING,
  ).show(context);
}

/// Error ///
void showFlashBarError({
  required BuildContext context,
  required String message,
}) {
  Flushbar(
    duration: const Duration(seconds: 3),
    message: message,
    messageColor: Colors.white,
    messageSize: 13.sp,
    margin: EdgeInsets.symmetric(horizontal: 40.w, vertical: 18.h),
    padding: EdgeInsets.all(14.sp),
    backgroundColor: AppColors.dangerSwatch.withOpacity(.9),
    borderRadius: BorderRadius.circular(30.sp),
    flushbarPosition: FlushbarPosition.TOP,
    flushbarStyle: FlushbarStyle.FLOATING,
  ).show(context);
}

/// Exit ///
void pressAgainToExit({
  required BuildContext context,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      width: 150.w,
      duration: const Duration(seconds: 2),
      content: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30.sp)),
        alignment: Alignment.center,
        child: AutoSizeTextWidget(
          text: 'Click again to exit',
          colorText: Colors.white,
          fontSize: 15.sp,
          minFontSize: 3,
          maxFontSize: 20,
          textAlign: TextAlign.center,
        ),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.black54.withOpacity(.8),
    ),
  );
}
