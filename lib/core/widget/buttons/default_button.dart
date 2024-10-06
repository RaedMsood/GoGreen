import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gogreen/core/theme/app_colors.dart';
import 'package:gogreen/core/widget/auto_size_text_widget.dart';

class DefaultButtonWidget extends StatelessWidget {
  double? width = double.infinity;
  double? height;
  final Color? background;
  final Function()? onPressed;
  final String text;
  double? textSize;
  Color? textColor;
  double? borderRadius;
  double? maxFontSize;
  double? minFontSize;
  FontWeight? fontWeight;
  bool? gradient;

  bool? isLoading;

  DefaultButtonWidget({
    Key? key,
    this.width,
    this.height,
    this.background,
    this.onPressed,
    required this.text,
    this.textColor,
    this.textSize,
    this.fontWeight,
    this.borderRadius,
    this.maxFontSize,
    this.minFontSize,
    this.gradient = true,
    this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isLoading == true ? 0.5 : 1,
      child: Container(
        width: width,
        height: height ?? 40.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? 8.0.sp),
          gradient: LinearGradient(
            colors: gradient == true
                ? [
                    AppColors.primaryColor,
                    AppColors.primarySwatch.shade700,
                    AppColors.primarySwatch.shade600.withOpacity(.92),
                  ]
                : [
                    background ?? AppColors.primaryColor,
                    background ?? AppColors.primaryColor,
                  ],
          ),
        ),
        child: Center(
          child: MaterialButton(
            height: height ?? 40.h,
            minWidth: double.infinity,
            onPressed: onPressed,
            child: isLoading == true
                ? SpinKitCircle(
                    color: textColor ?? AppColors.whiteColor,
                    size: 20.r,
                  )
                : AutoSizeTextWidget(
                    text: text,
                    fontSize: textSize ?? 12.4.sp,
                    colorText: textColor ?? Colors.white,
                    textAlign: TextAlign.center,
                    maxFontSize: maxFontSize ?? 25,
                    minFontSize: minFontSize ?? 8,
                  ),
          ),
        ),
      ),
    );
  }
}
