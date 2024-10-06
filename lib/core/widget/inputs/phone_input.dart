import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gogreen/core/constants/app_icons.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'base_input.dart';

class PhoneInputWidget extends StatelessWidget {
  const PhoneInputWidget({
    Key? key,
    required this.formControlName,
    required this.hintText,
    this.onSubmitted,
    this.margin,
    this.max = 9,
  }) : super(key: key);
  final String formControlName;
  final String hintText;

  final EdgeInsets? margin;
  final Function(FormControl<Object?>)? onSubmitted;
  final int max;

  @override
  Widget build(BuildContext context) {
    return BaseInputWidget(
      formControlName: formControlName,
      margin: margin,
      hintText: hintText,
      prefix: Padding(
        padding: EdgeInsets.only(left: 12.w, right: 8.w),
        child: SvgPicture.asset(AppIcons.britishFlag),
      ),
      inputFormatters: [
        LengthLimitingTextInputFormatter(max),
        FilteringTextInputFormatter.digitsOnly,
      ],
      onSubmitted: onSubmitted,
      keyboardType: TextInputType.phone,
      validationMessages: {
        ValidationMessage.required: (e) => 'Phone Number is required',
        ValidationMessage.pattern: (e) => 'Invalid Phone Number',
      },
    );
  }
}
