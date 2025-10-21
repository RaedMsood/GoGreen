import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/core/theme/app_colors.dart';
import 'package:gogreen/core/widget/online_images_widget.dart';

class OfferCardWidget extends StatelessWidget {
  final dynamic offers;

  const OfferCardWidget({super.key, required this.offers});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 14.w),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child:  OnlineImagesWidget(
        imageUrl: offers.image ?? "",
        externalLink: true,
        fit: BoxFit.contain,
      ),
    );
  }
}

