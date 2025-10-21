import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/core/states/ui.state.dart';
import 'package:gogreen/core/theme/app_colors.dart';
import 'package:gogreen/core/widget/auto_size_text_widget.dart';
import 'package:gogreen/features/home/details/presentation/riverpod/company_detail_riverpod.dart';
import 'package:gogreen/features/home/main/presentation/widget/categories_filter_widget.dart';
import 'package:gogreen/features/home/main/presentation/widget/categories_shimmer_widget.dart';

class CategoriesWidget extends SliverPersistentHeaderDelegate {
  final int id;
  final double height;

  CategoriesWidget({
    required this.id,
    required this.height,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Consumer(
      builder: (context, ref, child) {
        var controller = ref.watch(companyDetailProvider(id));
        var provider = ref.read(companyDetailProvider(id).notifier);
        return Container(
          color: AppColors.scaffoldColor,
          child: UIState(
            state: controller.viewState,
            loadingState: Padding(
              padding:  EdgeInsets.only(top: 8.h),
              child: const CategoriesShimmerWidget(),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                2.h.verticalSpace,
                  Padding(
                  padding: EdgeInsets.all(14.sp),
                  child: const AutoSizeTextWidget(
                    text: "Categories",
                  ),
                ),
                if (controller.data.sections.isNotEmpty)
                  Flexible(
                    child: SizedBox(
                      height: 37.h,
                      child: ListView(

                        scrollDirection: Axis.horizontal,
                        children: [
                          CategoriesFilterWidget(
                            title: "All",
                            isActive: provider.sectionId == 0,
                            onTap: () {
                              provider.filterBySection(0);
                            },
                          ),
                          ...controller.data.sections.map((e) {
                            return CategoriesFilterWidget(
                              title: e.name,
                              isActive: e.id == provider.sectionId,
                              onTap: () {
                                provider.filterBySection(e.id);
                              },
                            );
                          }),
                          SizedBox(width: 16.w)
                        ],
                      ),
                    ),
                  ),
                4.h.verticalSpace,
                if (provider.filteredCategories.isNotEmpty)
                  Flexible(
                    child: ListView(
                       padding: EdgeInsets.only(top: 6.h),
                      scrollDirection: Axis.horizontal,
                      children: [
                        CategoriesFilterWidget.secondary(
                          title: "All",
                          isActive: provider.selectedCategories.contains(0),
                          onTap: () {
                            provider.filterByCategory(0);
                          },
                        ),
                        ...provider.filteredCategories.map((e) {
                          return CategoriesFilterWidget.secondary(
                            title: e.name,
                            isActive:
                                provider.selectedCategories.contains(e.id),
                            onTap: () {
                              provider.filterByCategory(e.id);
                            },
                          );
                        }),
                        SizedBox(width: 16.w)
                      ],
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
