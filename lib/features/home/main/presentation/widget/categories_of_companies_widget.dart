import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/core/theme/app_colors.dart';
import 'package:gogreen/core/constants/app_icons.dart';
import 'package:gogreen/core/states/ui.state.dart';
import 'package:gogreen/core/widget/auto_size_text_widget.dart';
import 'package:gogreen/features/home/main/presentation/riverpod/riverpod.dart';
import 'categories_filter_widget.dart';
import 'categories_shimmer_widget.dart';

class CategoriesOfCompanyWidget extends SliverPersistentHeaderDelegate {
  CategoriesOfCompanyWidget();

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Consumer(
      builder: (context, ref, child) {
        var provider = ref.read(companiesProvider.notifier);
        var controller = ref.watch(companiesProvider);
        return Container(
          color: AppColors.scaffoldColor,
          child: UIState(
            state: controller.viewState,
            loadingState: const CategoriesShimmerWidget(),
           // errorState: SizedBox(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(14.sp),
                  child: AutoSizeTextWidget(
                    text: "Categories",
                  ),
                ),
                Expanded(
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      CategoriesFilterWidget(
                        title: 'All Companies',
                        icon: AppIcons.allCompanies,
                        isActive: provider.filter == HomeCompaniesFilter.all,
                        onTap: () {
                          provider.changeFilter(HomeCompaniesFilter.all);
                        },
                      ),
                      CategoriesFilterWidget(
                        title: 'Most Rated',
                        icon: AppIcons.mostRated,
                        isActive: provider.filter == HomeCompaniesFilter.rated,
                        onTap: () {
                          provider.changeFilter(HomeCompaniesFilter.rated);
                        },
                      ),
                      CategoriesFilterWidget(
                        title: 'Most Ordered',
                        icon: AppIcons.mostOrdered,
                        isActive: provider.filter == HomeCompaniesFilter.famous,
                        onTap: () {
                          provider.changeFilter(HomeCompaniesFilter.famous);
                        },
                      ),
                      SizedBox(width: 21.5.w)
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
  double get maxExtent => 84.h;

  @override
  double get minExtent => kToolbarHeight + 36.h;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
