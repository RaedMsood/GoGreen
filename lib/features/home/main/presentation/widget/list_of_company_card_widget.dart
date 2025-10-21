import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gogreen/core/constants/assets_path.dart';
import 'package:gogreen/core/network/errors/error.model.wings.dart';
import 'package:gogreen/core/states/error.state.dart';
import 'package:gogreen/core/states/ui.state.dart';
import 'package:gogreen/core/states/view.state.dart';
import 'package:gogreen/core/widget/loading_widget.dart';
import 'package:gogreen/features/home/main/presentation/riverpod/riverpod.dart';
import 'package:gogreen/features/profiles/profile/presentation/riverpod/profile_riverpod.dart';
import 'company_card_widget.dart';
import 'company_shimmer_card_widget.dart';

class ListOfCompanyCardWidget extends ConsumerWidget {
  const ListOfCompanyCardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    var controller = ref.watch(companiesProvider);
    var favoritesController = ref.watch(favoriteCompaniesProvider);

    return UIState(
      state: controller.viewState,
      loadingState: const CompanyShimmerCardWidget(),
      errorState: ErrorState.container(
        error: controller.errorModel,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          controller.data.data.isEmpty
              ? ErrorState.container(
                  error: ErrorModel(
                    message: "No Companies",
                    icon: AppImages.noData,
                  ),
                )
              : MasonryGridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding:
                      EdgeInsets.symmetric(horizontal: 14.w, vertical: 18.h),
                  mainAxisSpacing: 16.r,
                  crossAxisSpacing: 24.r,

                  gridDelegate:
                      const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,

                  ),
                  itemBuilder: (context, index) {
                    return CompanyCardWidget(
                      id: controller.data.data[index].id,
                      image: controller.data.data[index].image.toString(),
                      name: controller.data.data[index].name.toString(),
                      rates: double.parse(
                          controller.data.data[index].rates.toString()),
                      address: controller.data.data[index].address.toString(),
                      isFavorite: favoritesController.indexWhere((element) =>
                                  element.id ==
                                  controller.data.data[index].id) !=
                              -1
                          ? true
                          : false,
                    );
                  },
                  itemCount: controller.data.data.length,
                ),
          if (controller.viewState == ViewState.loadingMore)
            const CircularProgressIndicatorWidget(),
        ],
      ),
    );
  }
}
