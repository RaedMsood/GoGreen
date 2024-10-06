import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gogreen/Core/theme/app_colors.dart';
import 'package:gogreen/core/constants/app_icons.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'base_input.dart';

class NameInputWidget extends StatelessWidget {
  final String formControlName;
  final String hintText;
  final String validation;
  final dynamic icon;
  final TextInputType? keyboardType;

  const NameInputWidget({
    Key? key,
    required this.formControlName,
    required this.hintText,
    required this.validation,
    this.icon,
    this.onSubmitted,
    this.keyboardType,
  }) : super(key: key);

  final Function(FormControl<Object?>)? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return BaseInputWidget(
      formControlName: formControlName,
      prefix: Padding(
        padding: EdgeInsets.symmetric(vertical: 11.h),
        child: SvgPicture.asset(
          icon ?? AppIcons.person,
          width: 2.w,
          color: AppColors.greySwatch.shade600.withOpacity(.66),
        ),
      ),
      hintText: hintText,
      inputFormatters: [
        FilteringTextInputFormatter.singleLineFormatter,
      ],
      onSubmitted: onSubmitted,
      keyboardType: keyboardType ?? TextInputType.name,
      validationMessages: {
        ValidationMessage.required: (e) => '$validation is required',
        ValidationMessage.minLength: (e) =>
            'validation.minLength'
      },
    );
  }
}
