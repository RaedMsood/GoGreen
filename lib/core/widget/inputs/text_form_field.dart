import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/core/theme/app_colors.dart';

class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType type;
  final Color? fillColor;
  final bool? isPassword;
  final String? label;
  final String? hintText;
  final Color? hintTextColor;
  final Color? labelTextColor;
  final double? hintFontSize;
  final double? labelFontSize;
  final BorderSide? borderSide;
  final BorderSide? borderSideError;
  final FormFieldValidator? fieldValidator;
  final ValueChanged? onSubmit;
  final ValueChanged? onChanged;
  final Function()? onTap;
  final Widget? prefix;
  final Widget? suffixIcon;
  final bool? expanded;
  final bool? autofocus;
  final int? maxLine;

  const TextFormFieldWidget({
    super.key,
    required this.controller,
    required this.type,
    this.fillColor,
    this.hintText,
    this.hintTextColor,
    this.hintFontSize,
    this.label,
    this.labelTextColor,
    this.labelFontSize,
    this.borderSide,
    this.borderSideError,
    this.fieldValidator,
    this.isPassword,
    this.prefix,
    this.suffixIcon,
    this.expanded,
    this.autofocus,
    this.maxLine,
    this.onTap,
    this.onChanged,
    this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLine ?? 1,
      controller: controller,
      keyboardType: type,
      validator: fieldValidator,
      obscureText: isPassword ?? false,
      autofocus: autofocus??false,
      onFieldSubmitted: onSubmit,
      onTap: onTap,
      onChanged: onChanged,
      cursorColor: AppColors.primaryColor,
      decoration: InputDecoration(
        fillColor: fillColor ?? Colors.white,
        filled: true,
        hintText: hintText,
        labelText: label,
        hintStyle: TextStyle(
          fontSize: hintFontSize ?? 11.sp,
          color: hintTextColor ?? const Color(0xffa9a9a9),
          fontWeight: FontWeight.w400,
        ),
        labelStyle: TextStyle(
          fontSize: labelFontSize ?? 11.sp,
          color: labelTextColor ?? const Color(0xffa9a9a9),
          fontWeight: FontWeight.w400,
        ),
        border: InputBorder.none,
        errorBorder: OutlineInputBorder(
          borderSide: borderSideError ?? BorderSide.none,
          borderRadius: BorderRadius.circular(8.sp),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: borderSide ?? BorderSide.none,
          borderRadius: BorderRadius.circular(8.sp),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: borderSide ?? BorderSide.none,
          borderRadius: BorderRadius.circular(8.sp),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: borderSide ?? BorderSide.none,
          borderRadius: BorderRadius.circular(8.sp),
        ),
        prefixIcon: prefix,
        suffixIcon: suffixIcon,
        contentPadding: const EdgeInsets.all(10.0),
      ),
      expands: expanded ?? false,
      textAlign: TextAlign.start,
    );
  }
}
