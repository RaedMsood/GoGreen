import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gogreen/core/constants/app_icons.dart';
import 'package:gogreen/core/theme/app_colors.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'base_input.dart';

class PasswordInputWidget extends StatefulWidget {
  const PasswordInputWidget({
    super.key,
    required this.formControlName,
    required this.hintText,
    this.onSubmitted,
    this.margin,
  });
  final String formControlName;
  final String hintText;
  final EdgeInsets? margin;

  final Function(FormControl<Object?>)? onSubmitted;

  @override
  State<PasswordInputWidget> createState() => _PasswordInputWidgetState();
}

class _PasswordInputWidgetState extends State<PasswordInputWidget> {
  bool isShow = true;

  @override
  Widget build(BuildContext context) {
    return BaseInputWidget(
      margin: widget.margin,
      formControlName: widget.formControlName,
      hintText: widget.hintText,
      keyboardType: TextInputType.visiblePassword,
      onSubmitted: widget.onSubmitted,
      isPassword: isShow,
      prefix: Padding(
        padding: EdgeInsets.symmetric(vertical: 11.h),
        child: SvgPicture.asset(
          AppIcons.password,
          width: 4.w,
        ),
      ),
      suffix: IconButton(
        onPressed: () {
          setState(() {
            isShow = !isShow;
          });
        },
        icon: isShow
            ? Icon(
                Icons.visibility_off_outlined,
                color: AppColors.greySwatch.shade600.withOpacity(.38),
                size: 18.sp,
              )
            : Icon(
                Icons.visibility_outlined,
                color: AppColors.primaryColor,
                size: 18.sp,
              ),
      ),
      validationMessages: {
        ValidationMessage.required: (e) => "Password is required",
        ValidationMessage.minLength: (e) =>
            'Minimum password length is 6 characters',
        ValidationMessage.maxLength: (e) =>
            'Maximum password length is 20 characters',
        ValidationMessage.mustMatch: (e) => 'Password do not match',
      },
    );
  }
}
