import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/core/theme/app_colors.dart';
import 'package:gogreen/core/theme/buttons.dart';
import 'package:gogreen/core/widget/auto_size_text_widget.dart';


class TransportationCardWidget extends StatelessWidget {
  final String name;
  final String value;
  final String transportationGroupValue;
  final ValueChanged onChanged;
  final Function() onPressed;

  const TransportationCardWidget({
    super.key,
    required this.name,
    required this.value,
    required this.transportationGroupValue,

    required this.onChanged,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 3.h),
          margin: EdgeInsets.only(bottom: 12.h),
          decoration: BoxDecoration(
            color: AppColors.greySwatch.shade50,
            borderRadius: BorderRadius.circular(10.sp),
            border: Border.all(
                color: value == transportationGroupValue
                    ? AppColors.primaryColor
                    : AppColors.whiteColor,
                width: 0.8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AutoSizeTextWidget(
                text: name,
                fontSize: 12.6.sp,
              ),
              value == transportationGroupValue
                  ? SizedBox(
                      width: 20.w,
                      child: Radio(
                        value: value,
                        groupValue: transportationGroupValue,
                        activeColor: AppColors.primaryColor,
                        onChanged: onChanged,
                        splashRadius: 30,
                      ),
                    )
                  : SizedBox(
                      width: 26.5.w,
                      child: IconButton(
                        splashColor: AppColors.primarySwatch.shade300,
                        onPressed: onPressed,
                        iconSize: 18.r,
                        icon: const Icon(
                          Icons.circle,
                          color: Color(0xffe4eae8),
                        ),
                        style: WingsButtons.circleStyle,
                      ),
                    ),
            ],
          )),
    );
  }
}
