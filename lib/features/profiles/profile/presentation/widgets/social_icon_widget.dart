import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gogreen/core/theme/app_colors.dart';
import 'package:gogreen/core/theme/buttons.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialIconWidget extends StatelessWidget {
  final String icon;
  final String link;

  const SocialIconWidget({
    super.key,
    required this.icon,
    required this.link,
  });

  @override
  Widget build(BuildContext context) {
    if (link.isEmpty) return const SizedBox();
    return Container(
      child: TextButton(
        onPressed: () {
          launchUrl(Uri.parse(link));
        },
        style: WingsButtons.circleStyle,
        child: SvgPicture.asset(
          icon,
          width: 30.w,
          height: 30.h,
          color: AppColors.primaryColor,
        ),
      ),
    );
  }
}