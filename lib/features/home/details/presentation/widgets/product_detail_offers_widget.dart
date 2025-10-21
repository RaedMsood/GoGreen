import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/core/states/ui.state.dart';
import 'package:gogreen/core/theme/app_colors.dart';
import 'package:gogreen/core/widget/online_images_widget.dart';
import 'package:gogreen/features/home/details/presentation/riverpod/company_detail_riverpod.dart';
import '../../../../../core/widget/error_in_offers_widget.dart';
import '../../../../../core/widget/offers_shimmer_widget.dart';
import '../../../../../core/widget/smooth_page_indicator_widget.dart';

class ProductDetailOffersWidget extends ConsumerStatefulWidget {
  final int id;

  const ProductDetailOffersWidget({super.key, required this.id});

  @override
  ConsumerState<ProductDetailOffersWidget> createState() =>
      _ProductDetailOffersWidgetState();
}

class _ProductDetailOffersWidgetState
    extends ConsumerState<ProductDetailOffersWidget> {
  int pageController = 0;

  @override
  Widget build(BuildContext context) {
    var controller = ref.watch(productDetailProvider(widget.id));
    return UIState(
      state: controller.viewState,
      loadingState: Padding(
        padding:  EdgeInsets.only(top: 85.h),
        child: const OffersShimmerWidget(),
      ),
      errorState: Padding(
        padding: EdgeInsets.only(top: 85.h),
        child: const ErrorInOffersWidget(),
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: 170.h,
              autoPlay: true,
              aspectRatio: 2,
              viewportFraction: 1,
              enlargeCenterPage: true,
              autoPlayInterval: const Duration(seconds: 5),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
              reverse: true,

              onPageChanged: (index, reason) {
                setState(() {
                  pageController = index;
                });
              },
            ),
            items: [
              controller.data.image,
              ...?controller.data.slider,
            ].map((e) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 14.w),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: OnlineImagesWidget(
                  imageUrl: e,
                  externalLink: true,
                  fit: BoxFit.contain,
                ),
              );
            }).toList(),
          ),
          SmoothPageIndicatorWidget(
            pageController: pageController,
            count: [
              controller.data.image,
              ...?controller.data.slider,
            ].length,
          ),
        ],
      ),
    );
  }
}
