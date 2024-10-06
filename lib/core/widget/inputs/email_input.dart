import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gogreen/core/constants/app_icons.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'base_input.dart';

class EmailInputWidget extends StatelessWidget {
  const EmailInputWidget(
      {Key? key, required this.formControlName, required this.hintText, this.onSubmitted})
      : super(key: key);
  final String formControlName;
  final String hintText;

  final Function(FormControl<Object?>)? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return BaseInputWidget(
      formControlName: formControlName,
      hintText: hintText,
      prefix: Padding(
    padding: EdgeInsets.symmetric(vertical: 11.h),
    child: SvgPicture.asset(
    AppIcons.emailUser,
    width: 2.w,
    ),
    ),
      inputFormatters: [
        FilteringTextInputFormatter.singleLineFormatter,
      ],
      onSubmitted: onSubmitted,
      keyboardType: TextInputType.emailAddress,
      validationMessages: {
        ValidationMessage.required: (e) => 'Email is required',

      },
    );
  }
}
