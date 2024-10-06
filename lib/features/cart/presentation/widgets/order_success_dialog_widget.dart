import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/core/theme/app_colors.dart';
import 'package:gogreen/core/widget/auto_size_text_widget.dart';
import 'package:gogreen/core/widget/bottomNavbar/bottom_navigation_bar_widget.dart';
import 'package:gogreen/core/widget/buttons/default_button.dart';
import 'package:gogreen/core/helpers/navigateTo.dart';

class OrderSuccessDialogWidget extends ConsumerWidget {
  const OrderSuccessDialogWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return Container(
      padding: EdgeInsets.all(14.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.sp),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 88.h,
            width: 94.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100.sp),
              gradient: LinearGradient(
                colors: [
                  AppColors.primaryColor,
                  AppColors.primarySwatch.shade700,
                  AppColors.primarySwatch.shade600.withOpacity(.92),
                ],
              ),
            ),
            child: Icon(
              Icons.check_sharp,
              color: Colors.white,
              size: 38.sp,
            ),
          ),
          14.h.verticalSpace,
          AutoSizeTextWidget(
            text: "Transaction Successful",
            fontSize: 15.sp,
            fontWeight: FontWeight.w700,
            textAlign: TextAlign.center,
          ),
          8.h.verticalSpace,
          AutoSizeTextWidget(
            text:
                "Your order has been successful placed. Thank you for shopping with us.",
            fontSize: 12.sp,
            colorText: AppColors.greySwatch.shade600,
            maxLines: 3,
            textAlign: TextAlign.center,
          ),
          18.h.verticalSpace,
          DefaultButtonWidget(
            text: 'Back to Home',
            width: 130.w,
            height: 38.h,
            textSize: 11.4.sp,
            onPressed: () {
              ref.read(activeIndexProvider.notifier).state = 0;
              navigateAndFinish(context, const BottomNavigationBarWidget());
            },
          ),
        ],
      ),
    );
  }
}
