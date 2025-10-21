import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gogreen/core/constants/app_icons.dart';
import 'package:gogreen/core/theme/app_colors.dart';
import 'package:gogreen/core/widget/inputs/text_form_field.dart';
import 'package:gogreen/features/home/details/presentation/riverpod/company_detail_riverpod.dart';
import 'appbar_company_details.dart';

class SearchForAProductForTheCompanyDetailsAppBarSliverWidget
    extends SliverPersistentHeaderDelegate {
  final int id;
  final String companyImage;
  final String companyName;
  final String companyAddress;
  final CompanyDetailController controller;

  SearchForAProductForTheCompanyDetailsAppBarSliverWidget({
    required this.id,
    required this.companyImage,
    required this.companyName,
    required this.companyAddress,
    required this.controller,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Consumer(
      builder: (context, ref, child) {
        var provider = ref.read(companyDetailProvider(id).notifier);

        return CustomScrollView(
          physics: const NeverScrollableScrollPhysics(),
          slivers: [
            appBarCompanyDetailsWidget(
              title: companyName,
              companyId: id,
              companyImage: companyImage,
              companyName: companyName,
              companyAddress: companyAddress,
              context: context,
              expandedHeight: 140.h,
              child: AnimatedContainer(
                margin: EdgeInsets.all(14.sp),
                alignment: const AlignmentDirectional(1, 1),
                duration: const Duration(seconds: 2),
                curve: Curves.easeOutQuint,
                child: SizedBox(
                  height: 34.h,
                  child: TextFormFieldWidget(
                    controller: controller.searchController,
                    type: TextInputType.text,
                    hintText: "Search for",
                    hintTextColor: AppColors.greySwatch.shade400,
                    onChanged: (value) {
                      /// Search for the product
                      controller.search();

                      /// Open the keyboard
                      provider.keyboardAutoFocus = true;

                      /// Close the keyboard
                      Future.delayed(const Duration(milliseconds: 800)).then(
                        (value) => provider.keyboardAutoFocus = false,
                      );
                    },
                    autofocus: true,
                    prefix: Padding(
                      padding: EdgeInsets.symmetric(vertical: 7.5.h),
                      child: SvgPicture.asset(
                        AppIcons.search,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  double get maxExtent => 140.h;

  @override
  double get minExtent => 140.h;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
