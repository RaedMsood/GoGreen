import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gogreen/core/constants/app_icons.dart';
import 'package:gogreen/core/helpers/flash_bar_helper.dart';
import 'package:gogreen/core/states/view.state.dart';
import 'package:gogreen/core/theme/app_colors.dart';
import 'package:gogreen/core/widget/auto_size_text_widget.dart';
import 'package:gogreen/core/widget/bottomNavbar/bottom_navigation_bar_widget.dart';
import 'package:gogreen/core/widget/buttons/default_button.dart';
import 'package:gogreen/features/profiles/profile/presentation/riverpod/profile_riverpod.dart';

class LogoutDialog extends ConsumerWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context, ref) {
    var controller = ref.watch(logoutProvider);
    return Padding(
      padding: EdgeInsets.all(14.sp),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            backgroundColor: AppColors.dangerColor.withOpacity(.24),
            radius: 42.sp,
            child: SvgPicture.asset(
              AppIcons.logout,
              height: 20.h,
              color: AppColors.dangerColor,
            ),
          ),
          16.h.verticalSpace,
          AutoSizeTextWidget(
            text: "Logout",
            fontSize: 15.sp,
            fontWeight: FontWeight.w700,
            textAlign: TextAlign.center,
          ),
          12.h.verticalSpace,
          AutoSizeTextWidget(
            text: "Do you really want to sign out?",
            colorText: AppColors.greySwatch.shade600,
            fontSize: 13.5.sp,
            textAlign: TextAlign.center,
          ),
          6.h.verticalSpace,
          AutoSizeTextWidget(
            text: "We hope you’ll be back soon.",
            colorText: AppColors.greySwatch.shade600,
            fontSize: 13.5.sp,
            textAlign: TextAlign.center,
          ),
          24.h.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: DefaultButtonWidget(
                  text: 'Cancel',
                  height: 44.h,
                  borderRadius: 20.sp,
                  gradient: false,
                  background: AppColors.greySwatch.shade50,
                  textColor: AppColors.greySwatch.shade800,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              14.w.horizontalSpace,
              Expanded(
                child: DefaultButtonWidget(
                  text: 'Yes, Logout',
                  height: 44.h,
                  borderRadius: 20.sp,
                  gradient: false,
                  background: AppColors.dangerColor.withOpacity(.95),
                  isLoading: controller.viewState == ViewState.loading,
                  onPressed: () {
                    ref.read(logoutProvider.notifier).logout(
                          context: context,
                          onSuccess: () {
                            Navigator.of(context).pop();
                            ref.read(activeIndexProvider.notifier).state = 0;
                            showFlashBarSuccess(
                              message: "Logout successfully",
                              context: context,
                            );
                          },
                        );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
