import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gogreen/core/constants/app_icons.dart';
import 'package:gogreen/core/theme/app_colors.dart';
import 'package:gogreen/core/widget/appbar_sliver_widget.dart';
import 'package:gogreen/core/widget/inputs/text_form_field.dart';
import 'package:gogreen/features/home/main/presentation/riverpod/riverpod.dart';

class AppBarSearchCompaniesHeaderDelegate extends SliverPersistentHeaderDelegate {
  final SearchCompaniesRiverpodController controller;

  AppBarSearchCompaniesHeaderDelegate({required this.controller});


  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return CustomScrollView(
      physics: const NeverScrollableScrollPhysics(),

      slivers: [
        appBarSliverWidget(
          title: "Search",
          expandedHeight: 158.h,
          child: AnimatedContainer(
            margin: EdgeInsets.symmetric(horizontal: 14.w,vertical: 16.h),
            alignment: const AlignmentDirectional(1, 1),
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeOutQuint,
            child: TextFormFieldWidget(
              controller: controller.searchTextController,
              type: TextInputType.text,
              hintText: "Search for the company",
              hintTextColor: AppColors.greySwatch.shade400,
              onChanged: (value) {
                controller.onSearch(value);
              },
              prefix: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: SvgPicture.asset(
                  AppIcons.search,
                ),
              ),
              suffixIcon:   IconButton(
                onPressed: () {
                  controller.clearSearch();
                },
                icon: SvgPicture.asset(
                  AppIcons.close,
                  height: 16.r,
                  width: 16.r,
                  // color:  AppColors.primaryColor,
                  colorFilter:
                  ColorFilter.mode(AppColors.dangerColor, BlendMode.srcIn),
                ),
              ),
            ),
          ),
        ),




      ],
    );
  }

  @override
  double get maxExtent => 158.h;

  @override
  double get minExtent => 158.h;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}