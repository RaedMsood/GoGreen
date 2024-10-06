import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/core/theme/app_colors.dart';
import 'package:gogreen/core/theme/buttons.dart';
import 'package:gogreen/core/widget/auto_size_text_widget.dart';
import 'package:gogreen/core/widget/online_images_widget.dart';

class PaymentMethodWidget extends StatelessWidget {
  final String name;
  final String image;
  final String value;
  final String paymentMethodGroupValue;
  final String subtitle;
  final ValueChanged onChanged;
  final Function() onPressed;


  const PaymentMethodWidget({
    super.key,
    required this.name,
    required this.image,
    required this.value,
    required this.paymentMethodGroupValue,
    required this.subtitle,
    required this.onChanged,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(8.sp),
        margin: EdgeInsets.only(bottom: 11.h),
        decoration: BoxDecoration(
          color: AppColors.greySwatch.shade50,
          borderRadius: BorderRadius.circular(10.sp),
        ),
        child: Row(
          children: [

            OnlineImagesWidget(
              size: Size(50.w, 45.h),
              imageUrl: image,
              fit: BoxFit.contain,
              externalLink: true,
            ),
            12.w.horizontalSpace,
            Flexible(
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 1.4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeTextWidget(
                      text: name.toString(),
                      fontSize: 11.4.sp,
                    ),
                    6.h.verticalSpace,
                    AutoSizeTextWidget(
                      text: subtitle.toString(),
                      fontSize: 9.5.sp,
                      colorText: AppColors.greySwatch.shade600,
                    ),
                  ],
                ),
              ),
            ),
            value == paymentMethodGroupValue
                ? SizedBox(
                    width: 20.w,
                    child: Radio(
                      value: value,
                      groupValue: paymentMethodGroupValue,
                      activeColor: AppColors.primaryColor,
                      onChanged: onChanged,
                      splashRadius: 30,
                    ),
                  )
                : SizedBox(
                    width: 24.5.w,
                    child: IconButton(
                      splashColor: AppColors.primarySwatch.shade300,
                      onPressed: onPressed,
                      iconSize: 17.r,
                      icon: const Icon(
                        Icons.circle,
                        color: Color(0xffe4eae8),
                      ),
                      style: WingsButtons.circleStyle,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
