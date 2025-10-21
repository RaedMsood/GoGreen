import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gogreen/core/constants/app_icons.dart';
import 'package:gogreen/core/widget/auto_size_text_widget.dart';
import 'package:gogreen/core/constants/app_images.dart';
import 'package:gogreen/core/theme/app_colors.dart';
import 'package:gogreen/core/helpers/navigateTo.dart';
import 'package:gogreen/features/home/notifications/presentation/pages/notification_page.dart';
import 'package:gogreen/features/services/auth/auth.dart';
import 'package:gogreen/features/user/presentation/pages/login_page.dart';

SliverAppBar homeSliverAppBarWidget({
  required BuildContext context,
  required double expandedHeight,
  required Widget child,
}) {
  return SliverAppBar(
    automaticallyImplyLeading: false,
    backgroundColor: AppColors.transparent,
    pinned: true,
    floating: true,
    expandedHeight: expandedHeight,
    toolbarHeight: 70.h,
    elevation: 0.0,
    leadingWidth: 60.w,

    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeTextWidget(
          text: Auth().storeAddress.isEmpty
              ? "Welcome to GoGreen"
              : "Your Address",
          colorText: Colors.white,
          fontSize: 13.sp,
          fontWeight: FontWeight.w300,
        ),
        4.h.verticalSpace,
        Auth().storeAddress.isEmpty
            ? const SizedBox()
            : Row(
                children: [
                  SvgPicture.asset(AppIcons.locationHome),
                  2.w.horizontalSpace,
                  Flexible(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 1.8,
                      child: AutoSizeTextWidget(
                        text: Auth().storeAddress,
                        colorText: Colors.white,
                        fontSize: 11.2.sp,
                        minFontSize: 11,
                        maxLines: 2,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ],
              ),
      ],
    ),
    actions: [
      SizedBox(
        height: 20.h,
        width: 40.w,
      ),
      Padding(
        padding: EdgeInsets.only(right: 14.w),
        child: InkWell(
          borderRadius: BorderRadius.circular(100.sp),
          onTap: () {
            if (!Auth().loggedIn) {
              navigateTo(
                context,
                const LogInPage(),
              );
            } else {
              navigateTo(context, const NotificationsPage());
            }

          },
          child: SvgPicture.asset(
            !Auth().loggedIn?AppIcons.notification:  AppIcons.newNotification,
          ),
        ),
      ),
    ],
    flexibleSpace: Container(
      padding: EdgeInsets.zero,
      height: expandedHeight,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(18.r),
          bottomRight: Radius.circular(18.r),
        ),
        image: const DecorationImage(
          image: AssetImage(
            AppImages.topPattern,
          ),
          alignment: Alignment.topLeft,
        ),
      ),
      child: child,
    ),
  );
}
