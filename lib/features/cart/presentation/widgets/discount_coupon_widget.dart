import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/Core/theme/app_colors.dart';
import 'package:gogreen/core/widget/auto_size_text_widget.dart';
import 'package:gogreen/core/widget/inputs/text_form_field.dart';

class DiscountCouponWidget extends StatelessWidget {
  final String discountCoupon;
  DiscountCouponWidget({super.key, required this.discountCoupon});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        8.h.verticalSpace,
        AutoSizeTextWidget(
          text: "Discount Coupon",
          fontSize: 12.sp,
          fontWeight: FontWeight.w700,
        ),
        8.h.verticalSpace,
        SizedBox(
          height: 40.h,
          child: TextFormFieldWidget(
            type: TextInputType.text,
            controller: TextEditingController(text: discountCoupon),
            fillColor: AppColors.greySwatch.shade50,
            hintFontSize: 10.sp,
            hintText: "Discount Coupon",
            suffixIcon:  Padding(
              padding:  EdgeInsets.all(4.sp),
              child:  Container(
                width: 82.w,
                decoration: BoxDecoration(
                  color: AppColors.brownColor,
                  borderRadius: BorderRadius.circular( 8.0.sp),
                ),
                child: Center(
                  child: MaterialButton(

                    minWidth: double.infinity,
                    onPressed: (){

                    },
                    child: AutoSizeTextWidget(
                      text: 'application',
                      fontSize: 9.sp,
                      colorText: AppColors.whiteColor,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ) ,
          ),
        ),
        20.h.verticalSpace,


      ],
    );
  }
}
