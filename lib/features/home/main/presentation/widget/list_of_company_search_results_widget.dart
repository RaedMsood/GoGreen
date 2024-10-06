import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gogreen/core/states/error.state.dart';
import 'package:gogreen/core/states/ui.state.dart';
import 'package:gogreen/features/home/main/presentation/riverpod/riverpod.dart';
import 'package:gogreen/features/home/main/presentation/widget/company_card_widget.dart';
import 'package:gogreen/features/home/main/presentation/widget/company_shimmer_card_widget.dart';
import 'package:gogreen/features/profiles/profile/presentation/riverpod/profile_riverpod.dart';

class ListOfCompanySearchResultsWidget extends ConsumerWidget {
  const ListOfCompanySearchResultsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    var controller = ref.watch(searchCompaniesProvider);
    var favoritesController = ref.watch(favoriteCompaniesProvider);

    return UIState(
      state: controller.viewState,
      loadingState: Padding(
        padding: EdgeInsets.only(top: 14.h),
        child: const CompanyShimmerCardWidget(),
      ),
      errorState: ErrorState.container(
        error: controller.errorModel,
      ),
      child: MasonryGridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.all(14.sp),
        mainAxisSpacing: 16.r,
        crossAxisSpacing: 24.r,
        gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) {
          return CompanyCardWidget(
            id: controller.data.data[index].id,
            image: controller.data.data[index].image.toString(),
            name: controller.data.data[index].name.toString(),
            rates:  double.parse(controller.data.data[index].rates.toString()),
            address: controller.data.data[index].address.toString(),
            isFavorite:favoritesController.indexWhere((element) => element.id==controller.data.data[index].id) != -1?true:false,
          );
        },
        itemCount: controller.data.data.length,
      ),
    );
  }
}
