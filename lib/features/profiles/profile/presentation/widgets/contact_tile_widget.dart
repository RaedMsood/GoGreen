import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gogreen/core/constants/app_icons.dart';
import 'package:gogreen/core/theme/app_colors.dart';
import 'package:gogreen/core/theme/text_style.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactTileWidget extends StatelessWidget {
  final String title;
  final String icon;

  const ContactTileWidget({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 4.h),
      child: GestureDetector(
        onTap: () {
          //open the phone dialer using url_launcher
          if (icon == AppIcons.phone) {
            final Uri call = Uri(
              scheme: 'tel',
              path: title,
            );
            launchUrl(call);
          } else if (icon == AppIcons.email) {
            final Uri email = Uri(
              scheme: 'mailto',
              path: title,
            );
            launchUrl(email);
          }
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 4.h),
          child: Row(
            children: [
              SvgPicture.asset(
                icon,
                width: 20.w,
                height: 20.h,
                color: AppColors.primaryColor,
              ),
              SizedBox(width: 10.w),
              Text(
                title,
                style: AppTextStyle.regular16,
                textDirection: TextDirection.ltr,
              ),
            ],
          ),
        ),
      ),
    );
  }
}