import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gogreen/core/constants/app_icons.dart';
import 'package:gogreen/core/theme/app_colors.dart';
import 'package:gogreen/core/widget/auto_size_text_widget.dart';
import 'package:gogreen/core/widget/gradient_widget.dart';
import 'package:gogreen/core/helpers/navigateTo.dart';
import 'package:gogreen/core/widget/rating_bar_widget.dart';
import 'package:gogreen/core/theme/buttons.dart';
import 'package:gogreen/core/widget/online_images_widget.dart';
import 'package:gogreen/features/home/details/presentation/pages/company_details_page.dart';
import 'package:gogreen/features/profiles/profile/data/model/companies_favorites_model.dart';
import 'package:gogreen/features/profiles/profile/presentation/riverpod/profile_riverpod.dart';

class CompanyCardWidget extends ConsumerWidget {
  final int id;
  final String image;
  final String name;
  final double rates;
  final String address;
  final bool isFavorite;

  const CompanyCardWidget({
    super.key,
    required this.id,
    required this.image,
    required this.name,
    required this.rates,
    required this.address,
    required this.isFavorite,
  });

  @override
  Widget build(BuildContext context, ref) {
    return GestureDetector(
      onTap: () {
        navigateTo(
            context,
            CompanyDetailsPage(
              id: id,
              companyImage: image,
              companyName: name,
              companyAddress: address,
            ));
      },
      child: Container(
        padding: EdgeInsets.all(8.sp),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.01),
              blurRadius: 2.r,
            ),
          ],
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OnlineImagesWidget(
              imageUrl: image,
              externalLink: true,
              size: Size(double.infinity, 100.r),
              showChild: true,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  /// Class Gradient
                  const GradientWidget(),

                  PositionedDirectional(
                    top: isFavorite ? -10.5.r : -8.r,
                    start: -10,
                    child: IconButton(
                      splashColor: AppColors.primarySwatch.shade50.withOpacity(.6),
                      highlightColor: AppColors.primarySwatch.shade50.withOpacity(.4),
                      onPressed: () {
                        var companiesFavorites = CompaniesFavoritesModel(
                          id: id,
                          image: image,
                          name: name,
                          address: address,
                          rates: rates,
                        );
                        ref
                            .read(favoriteCompaniesProvider.notifier)
                            .toggleFavourite(companiesFavorites);
                        ref
                            .read(favoriteCompaniesProvider.notifier)
                            .getAllFavourites();
                      },
                      style: WingsButtons.circleStyle,
                      icon: SvgPicture.asset(
                        isFavorite
                            ? AppIcons.favoriteActive
                            : AppIcons.favorite,
                        allowDrawingOutsideViewBox: true,
                        height: isFavorite ? 20.h : 18.r,
                        width: 18.r,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            8.h.verticalSpace,
            AutoSizeTextWidget(
              text: name,
              maxLines: 2,
              fontSize: 12.sp,
              minFontSize: 11,
            ),
            7.h.verticalSpace,
            RatingBarWidget(
              evaluation: rates,
              labeledColor: AppColors.secondaryColor,
              itemSize: 14.sp,
            ),
            6.h.verticalSpace,
            AutoSizeTextWidget(
              text: address,
              colorText: AppColors.greySwatch.shade400,
              fontWeight: FontWeight.w400,
              maxLines: 2,
              fontSize: 9.8.sp,
              minFontSize: 8,
            ),
          ],
        ),
      ),
    );
  }
}
