import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/core/constants/app_images.dart';
import 'package:gogreen/core/helpers/navigateTo.dart';
import 'package:gogreen/core/theme/app_colors.dart';
import 'package:gogreen/core/widget/auto_size_text_widget.dart';
import 'package:gogreen/core/widget/buttons/back_button_widget.dart';
import 'package:gogreen/features/home/evaluation/presentation/pages/evaluation_page.dart';

SliverAppBar appBarCompanyDetailsWidget({
  required String title,
  required int companyId,
  required String companyImage,
  required String companyName,
  required String companyAddress,
  required Widget child,
  required double expandedHeight,
  required BuildContext context,
  bool actions = false,
}) {
  return SliverAppBar(
    automaticallyImplyLeading: false,
    backgroundColor: AppColors.transparent,
    centerTitle: true,
    pinned: true,
    floating: true,
    expandedHeight: expandedHeight,
    toolbarHeight: 70.h,
    elevation: 0.0,
    leadingWidth: 60.w,
    title: AutoSizeTextWidget(
      text: title,
      colorText: Colors.white,
      fontSize: 14.5.sp,
      minFontSize: 10,
      maxLines: 2,
    ),
    leading: const BackButtonWidget(),
    actions: [
     actions==true? SizedBox(
        height: 20.h,
        width: 40.w,
      ):const SizedBox.shrink(),
      Padding(
        padding: EdgeInsets.only(right: 14.w),
        child: InkWell(
          borderRadius: BorderRadius.circular(100.sp),

          onTap: () {
            navigateTo(
                context,
                EvaluationPage(
                  id: companyId,
                  companyImage: companyImage,
                  companyName: companyName,
                  companyAddress: companyAddress,
                ));
          },
          child: CircleAvatar(
            radius: 21.sp,
            backgroundColor: Colors.white12,
            child:  Icon(
              Icons.star,
              size: 20.sp,
              color: Colors.white,
            ),
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
