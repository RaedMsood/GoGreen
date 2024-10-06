import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gogreen/core/theme/app_colors.dart';
import 'package:gogreen/core/widget/auto_size_text_widget.dart';

import 'buttons/back_button_widget.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double? titleFontSize;
  final bool leading;
  final bool action;
  final String actionIcon;
  final Function()? onTapAction;

   AppBarWidget({
    super.key,
    required this.title,
     this.titleFontSize,
    this.leading = true,
    this.action = false,
    this.actionIcon="",
    this.onTapAction,
  });

  @override
  Size get preferredSize => Size.fromHeight(80.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 65.h,
      automaticallyImplyLeading: false,
      elevation: 0.0,
      leadingWidth: leading == true ? 65.w : 0,
      centerTitle: true,
      leading: Visibility(
        visible: leading,
        child: const BackButtonWidget(),
      ),
      title: AutoSizeTextWidget(
        text: title,
        colorText: Colors.white,
        fontSize: titleFontSize?? 16.sp,
        minFontSize: 14,
        maxLines: 2,
        fontWeight: FontWeight.w500,
      ),
      actions: [
        Visibility(
            visible: action,
            child: Padding(
              padding:  EdgeInsets.only(right: 14.w,top: 4.h),
              child: GestureDetector(
                onTap: onTapAction,
                child: CircleAvatar(
                  radius: 22.sp,
                  backgroundColor: Colors.white12,
                  child: SvgPicture.asset(
                    actionIcon,
                    height: 18.h,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
        ),
      ],
      flexibleSpace: Container(
        alignment: Alignment.bottomLeft,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(18.sp),
            bottomRight: Radius.circular(18.sp),
          ),
          image: const DecorationImage(
            alignment: Alignment.bottomLeft,
            image: AssetImage("assets/images/feather2.png"),
          ),
        ),
      ),

    );
  }
}
