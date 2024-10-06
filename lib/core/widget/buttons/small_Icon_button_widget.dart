import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gogreen/core/theme/app_colors.dart';

class SmallIconButtonWidget extends StatelessWidget {
  final String icon;

  final Function()? onPressed;

  const SmallIconButtonWidget({super.key, required this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 25.w,
      height: 24.h,
      child: IconButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor:
              const MaterialStatePropertyAll(AppColors.primarySwatch),
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.r),
            ),
          ),
        ),
        icon: SvgPicture.asset(
          icon,
          height: 8.5.h,
          color: Colors.white,
        ),
      ),
    );
  }
}
