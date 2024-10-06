import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/core/states/ui.state.dart';
import 'package:gogreen/features/home/offers/presentation/riverpod/offers_riverpod.dart';
import 'error_in_categories_widget.dart';
import 'offer_card_widget.dart';
import 'offers_shimmer_widget.dart';
import 'smooth_page_indicator_widget.dart';

class HomeOffersWidget extends ConsumerStatefulWidget {
  const HomeOffersWidget({super.key});

  @override
  ConsumerState<HomeOffersWidget> createState() => _HomeOffersWidgetState();
}

class _HomeOffersWidgetState extends ConsumerState<HomeOffersWidget> {
  int pageController = 0;

  @override
  Widget build(BuildContext context) {
    var controller = ref.watch(homeOffersControllerProvider);
    return UIState(
      state: controller.viewState,
      loadingState: const OffersShimmerWidget(),
      errorState: ErrorInCategoriesWidget(),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: 160.h,
              autoPlay: true,
              aspectRatio: 2,
              viewportFraction: 1,
              enlargeCenterPage: true,
              autoPlayInterval: const Duration(seconds: 5),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
              onPageChanged: (index, reason) {
                setState(() {
                  pageController = index;
                });
              },
            ),
            items: controller.data.map<Widget>((e) {
              return OfferCardWidget(
                offers: e,
              );
            }).toList(),
          ),
          SmoothPageIndicatorWidget(
            pageController: pageController,
            count: controller.data.toList().length,
          ),
        ],
      ),
    );
  }
}
