import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gogreen/core/constants/app_icons.dart';
import 'package:gogreen/core/theme/app_colors.dart';
import 'package:gogreen/core/widget/appbar_sliver_widget.dart';
import 'package:gogreen/core/widget/inputs/text_form_field.dart';
import 'package:gogreen/features/home/details/presentation/riverpod/company_detail_riverpod.dart';
import 'package:gogreen/features/home/offers/presentation/widget/company_details_offers_widget.dart';

class SearchForAProductAndViewOffersForTheCompanyDetailsAppBarSliverWidget
    extends SliverPersistentHeaderDelegate {
  final int id;
  final String title;
  late double expandedHeight;
  final CompanyDetailController controller;
  final ScrollController scrollController;

  SearchForAProductAndViewOffersForTheCompanyDetailsAppBarSliverWidget({
    required this.id,
    required this.title,
    required this.expandedHeight,
    required this.controller,
    required this.scrollController,
  });

  late double hide = 0;
  late double height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    if (expandedHeight != 93.h) {
      hide = shrinkOffset / expandedHeight;
      height = expandedHeight / (shrinkOffset + 1);
    } else {
      hide = 0;
      height = expandedHeight;
    }

    return Consumer(
      builder: (context, ref, child) {
        ref.watch(companyDetailProvider(id));
        var provider = ref.read(companyDetailProvider(id).notifier);
        return CustomScrollView(
          physics: const NeverScrollableScrollPhysics(),
          slivers: [
            appBarSliverWidget(
              title: title,
              expandedHeight: expandedHeight,
              actions:hide > .6? true:false,
              child: Stack(
                fit: StackFit.expand,
                clipBehavior: Clip.none,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedContainer(
                        padding: MediaQuery.of(context).viewPadding.copyWith(
                              bottom: hide > .6 ? 0.h : 12.h,
                            ),
                        margin: EdgeInsets.only(
                          left: hide > .52 ? 300.w : 14.w,
                          right: 14.w,
                          top: hide > .6 ? 14.5.h : 70.h,
                        ),
                        alignment: hide > .6
                            ? const AlignmentDirectional(1, -1)
                            : const AlignmentDirectional(1, 1),
                        duration: const Duration(seconds: 2),
                        curve: Curves.easeOutQuint,
                        child: hide > .6

                            /// App bar actions
                            ? GestureDetector(
                                onTap: () {
                                  /// Back to top
                                  scrollController.animateTo(
                                    0,
                                    duration: const Duration(milliseconds: 600),
                                    curve: Curves.easeInOut,
                                  );

                                  /// Open the keyboard
                                  provider.keyboardAutoFocus = true;

                                  /// Close the keyboard
                                  Future.delayed(
                                          const Duration(milliseconds: 800))
                                      .then(
                                    (value) =>
                                        provider.keyboardAutoFocus = false,
                                  );
                                },
                                child: CircleAvatar(
                                  radius: 22.sp,
                                  backgroundColor: Colors.white12,
                                  child: SvgPicture.asset(
                                    AppIcons.search,
                                    height: 17.5.h,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : SizedBox(
                                height: 36.h,
                                width: ((MediaQuery.of(context).size.width) /
                                        (hide + (hide + 1)))
                                    .h,
                                child: TextFormFieldWidget(
                                  controller: controller.searchController,
                                  type: TextInputType.text,
                                  hintText: "Search for",
                                  hintTextColor: AppColors.greySwatch.shade400,
                                  autofocus: provider.keyboardAutoFocus,
                                  onChanged: (value) {
                                    /// Search for the product
                                    controller.search();
                                  },
                                  prefix: Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 7.5.h),
                                    child: SvgPicture.asset(
                                      AppIcons.search,
                                    ),
                                  ),
                                ),
                              ),
                      ),
                      Flexible(
                        child: AnimatedContainer(
                          duration: const Duration(seconds: 1),
                          curve: Curves.easeOutQuint,
                          alignment: const AlignmentDirectional(1, 1),
                          child: CompanyDetailsOffersWidget(id: id),
                        ),
                      ),
                      10.h.verticalSpace,
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight + 48.h;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
