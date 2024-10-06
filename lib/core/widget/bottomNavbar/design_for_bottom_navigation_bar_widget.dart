import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gogreen/core/theme/app_colors.dart';
import 'package:gogreen/core/theme/text_style.dart';

class DesignForBottomNavigationBarWidget extends StatelessWidget {
  final String icon;
  final bool active;

  final String? activeIcon;
  final String label;
  final Function()? onTap;

  const DesignForBottomNavigationBarWidget({
    super.key,
    required this.icon,
    this.activeIcon,
    required this.label,
    this.active = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.only(
              bottom: active ? 16.h : 8.h, top: active ? 6.h : 10.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 1000),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return ScaleTransition(
                    scale: animation,
                    child: child,
                  );
                },
                child: Padding(
                  padding: EdgeInsets.only(left: active ? 6.w : 0),
                  child: SvgPicture.asset(
                    active ? activeIcon ?? icon : icon,
                    key: ValueKey<String>(active ? activeIcon ?? icon : icon),
                    width: active ? 32.w : 21.w,
                    height: active ? 32.h : 21.h,
                  ),
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                label,
                style: AppTextStyle.regular10.copyWith(
                  color: active ? AppColors.secondaryColor : Colors.white,
                ),
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
