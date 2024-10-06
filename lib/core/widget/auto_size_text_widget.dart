import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AutoSizeTextWidget extends StatelessWidget {
  final String text;
 final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final Color? colorText;
  final int? maxLines;
  final double? maxFontSize;
  final double? minFontSize;

  const AutoSizeTextWidget({
    super.key,
    required this.text,
    this.fontSize,
    this.fontWeight,
    this.textAlign,
    this.colorText,
    this.maxLines,
    this.maxFontSize,
    this.minFontSize,
  });

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      style: TextStyle(
        fontWeight: fontWeight ?? FontWeight.w500,
        fontSize: fontSize ?? 14.sp,
        color: colorText ?? Colors.black,
        fontFamily: 'PlusJakartaSans',
      ),
      maxLines: maxLines ?? 1,
      maxFontSize: maxFontSize ?? 24,
      minFontSize: minFontSize ?? 10,
      overflow: TextOverflow.ellipsis,
      textAlign: textAlign ?? TextAlign.start,
    );
  }
}
