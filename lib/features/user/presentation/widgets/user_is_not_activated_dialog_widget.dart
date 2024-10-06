import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/core/states/view.state.dart';
import 'package:gogreen/core/theme/app_colors.dart';
import 'package:gogreen/core/widget/auto_size_text_widget.dart';
import 'package:gogreen/core/widget/buttons/default_button.dart';
import 'package:gogreen/core/helpers/navigateTo.dart';
import 'package:gogreen/features/user/presentation/pages/verify_page.dart';
import 'package:gogreen/features/user/presentation/riverpod/riverpod.dart';

class UserIsNotActivatedDialogWidget extends ConsumerWidget {
  const UserIsNotActivatedDialogWidget({super.key});

  @override
  Widget build(BuildContext context, ref) {
    var controller = ref.watch(resendOtpProvider);

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
            height: 84.h,
            width: 90.w,
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
              Icons.warning_amber_sharp,
              color: Colors.white,
              size: 32.sp,
            ),
          ),
          14.h.verticalSpace,
          AutoSizeTextWidget(
            text: "Account is not activated.",
            fontSize: 15.sp,
            fontWeight: FontWeight.w700,
            textAlign: TextAlign.center,
          ),
          8.h.verticalSpace,
          AutoSizeTextWidget(
            text: "Please go check OTP.",
            fontSize: 13.sp,
            colorText: AppColors.greySwatch.shade600,
            maxLines: 3,
            textAlign: TextAlign.center,
          ),
          30.h.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: DefaultButtonWidget(
                  text: 'Cancel',
                  height: 43.h,
                  borderRadius: 20.sp,
                  gradient: false,
                  background: AppColors.greySwatch.shade50,
                  textColor: AppColors.greySwatch.shade800,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              12.w.horizontalSpace,
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(18.r),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primarySwatch.shade200.withOpacity(.4),
                        blurRadius: 12.r,
                      ),
                    ],
                  ),
                  child: DefaultButtonWidget(
                    text: 'Check OTP',
                    height: 43.h,
                    borderRadius: 20.sp,
                    isLoading: controller.viewState == ViewState.loading,
                    onPressed: () {

                      ref.read(resendOtpProvider.notifier).resendOtp(context,
                          onSuccess: () {
                            // Navigator.of(context).pop();
                            // navigateTo(
                            // context,
                            // VerifyPage(
                            //   userIsNotActivated: true,
                            // ));
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
