import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/core/theme/app_colors.dart';
import 'package:gogreen/core/widget/auto_size_text_widget.dart';
import 'package:gogreen/core/widget/bottomNavbar/bottom_navigation_bar_widget.dart';
import 'package:gogreen/core/helpers/navigateTo.dart';
import 'package:gogreen/features/services/auth/auth.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../pages/splach_screen_page.dart';

class SplachScreenWidget extends StatelessWidget {
  final String title;
  final String description;
  final int boardingLength;
  final int currentIndex;
  final PageController controller ;

  const SplachScreenWidget({
    super.key,
    required this.title,
    required this.description,
    required this.currentIndex,
    required this.controller,
    required this.boardingLength,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(14.sp),
      child: Column(
        children: [
          14.h.verticalSpace,
          AutoSizeTextWidget(
            text:title,
            fontWeight: FontWeight.w700,
          ),
          10.h.verticalSpace,
          AutoSizeTextWidget(
            text: description,
            fontSize: 12.sp,
            colorText: AppColors.greySwatch.shade600.withOpacity(.5),
            textAlign: TextAlign.center,
            maxLines: 8,
          ),
          18.h.verticalSpace,
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                currentIndex == boardingLength - 1
                    ? const SizedBox()
                    : SmoothPageIndicator(
                        controller: controller,
                        count: 2,
                        effect: ExpandingDotsEffect(
                          dotColor:
                              AppColors.primarySwatch.shade100.withOpacity(.2),
                          activeDotColor: AppColors.primarySwatch.shade600,
                          dotHeight: 8,
                          dotWidth: 8,
                          expansionFactor: 6,
                          spacing: 5.0,
                        ),
                      ),
                Flexible(
                  child: Container(
                    width: currentIndex == boardingLength - 1
                        ? double.infinity
                        : 140.w,
                    height: 38.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.r),
                      gradient: LinearGradient(colors: [
                        AppColors.primarySwatch.shade700,
                        AppColors.primarySwatch.shade300,
                        AppColors.primarySwatch.shade100.withOpacity(.8),
                      ]),
                    ),
                    child: MaterialButton(
                      height: 38.h,
                      minWidth: double.infinity,
                      onPressed: () {
                        if (currentIndex == boardingLength- 1) {
                          Auth().cacheOnBoarding(true).then((value) {
                            navigateAndFinish(
                              context,
                              const BottomNavigationBarWidget(),
                            );
                          });
                        }
                        controller.nextPage(
                          duration: const Duration(milliseconds: 1000),
                          curve: Curves.ease,
                        );
                      },
                      child: AutoSizeTextWidget(
                        text: currentIndex == boardingLength - 1
                            ? "Get Started"
                            : "Next",
                        fontSize: 12.2.sp,
                        fontWeight: FontWeight.w700,
                        colorText: Colors.white,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
