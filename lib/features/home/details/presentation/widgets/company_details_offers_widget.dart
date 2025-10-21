import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/core/states/ui.state.dart';
import 'package:gogreen/features/home/details/presentation/riverpod/company_detail_riverpod.dart';
import '../../../../../core/widget/error_in_offers_widget.dart';
import '../../../../../core/widget/offer_card_widget.dart';
import '../../../../../core/widget/offers_shimmer_widget.dart';
import '../../../../../core/widget/smooth_page_indicator_widget.dart';

class CompanyDetailsOffersWidget extends ConsumerStatefulWidget {
  final int id;

  const CompanyDetailsOffersWidget( {super.key,required this.id});

  @override
  ConsumerState<CompanyDetailsOffersWidget> createState() =>
      _CompanyDetailsOffersWidgetState();
}

class _CompanyDetailsOffersWidgetState
    extends ConsumerState<CompanyDetailsOffersWidget> {
  int pageController = 0;

  @override
  Widget build(BuildContext context) {
    var controller = ref.watch(companyDetailProvider(widget.id));
    return UIState(
      state: controller.viewState,
      loadingState: const OffersShimmerWidget(),
      errorState: const ErrorInOffersWidget(),
      child:controller.data.offers.isEmpty? const ErrorInOffersWidget(): Stack(
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
            items: controller.data.offers.map((e) {
              return OfferCardWidget(
                offers: e,
              );
            }).toList(),
          ),
          SmoothPageIndicatorWidget(
            pageController: pageController,
            count: controller.data.offers.length,
          ),
        ],
      ),
    );
  }
}
