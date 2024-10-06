import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gogreen/core/constants/app_images.dart';
import 'package:gogreen/core/network/errors/error.model.wings.dart';
import 'package:gogreen/core/states/error.state.dart';
import 'package:gogreen/core/theme/app_colors.dart';
import 'package:gogreen/core/widget/appbar_widget.dart';
import 'package:gogreen/features/home/main/presentation/widget/company_card_widget.dart';
import 'package:gogreen/features/profiles/profile/presentation/riverpod/profile_riverpod.dart';

class FavoritesPage extends ConsumerWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    var controller = ref.watch(favoriteCompaniesProvider);

    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: AppBarWidget(
        title: "Favorites",
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (controller.isEmpty)
              ErrorState.container(
                error: ErrorModel(
                  message: 'Favorites empty',
                  desc: "Add your favorite company",
                  icon: AppImages.noData,
                ),
              )
            else
              MasonryGridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 18.h),
                mainAxisSpacing: 16.r,
                crossAxisSpacing: 24.r,
                gridDelegate:
                    const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) {
                  return CompanyCardWidget(
                    id: controller[index].id,
                    image: controller[index].image.toString(),
                    name: controller[index].name.toString(),
                    rates: double.parse(controller[index].rates.toString()),
                    address: controller[index].address.toString(),
                    isFavorite: true,
                  );
                },
                itemCount: controller.length,
              ),
          ],
        ),
      ),
    );
  }
}
