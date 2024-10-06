import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/core/theme/app_colors.dart';
import 'package:pinput/pinput.dart';

class VerifyPinputWidget extends StatelessWidget {
  final TextEditingController verifyController;

  const VerifyPinputWidget({super.key, required this.verifyController});

  @override
  Widget build(BuildContext context) {
    return  Pinput(
      controller: verifyController,
      crossAxisAlignment: CrossAxisAlignment.center,
      length: 6,
      defaultPinTheme: PinTheme(
        width: 66.w,
        height: 45.h,
        textStyle: TextStyle(
          fontSize: 16.sp,
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.sp),
        ),
      ),
      focusedPinTheme: PinTheme(
        width: 66.w,
        height: 45.h,
        decoration: BoxDecoration(
          color: AppColors.transparent,
          border: Border.all(color: AppColors.secondaryColor),
          borderRadius: BorderRadius.circular(12.sp),
        ),
      ),
      validator: (value) {
        if (value == null || value.toString().isEmpty) {
          return "Please enter the verification code";
        }
      },
    );
  }
}
