import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gogreen/core/constants/app_icons.dart';
import 'package:gogreen/core/helpers/navigateTo.dart';
import 'package:gogreen/features/home/main/presentation/widget/home_offers_widget.dart';
import 'package:gogreen/features/home/main/presentation/page/search_page.dart';
import 'search_box_widget.dart';
import 'home_sliver_appbar_widget.dart';

class SearchAndOffersForTheMainAppBarSliverWidget extends SliverPersistentHeaderDelegate {
  late double expandedHeight;

  SearchAndOffersForTheMainAppBarSliverWidget({
    required this.expandedHeight,
  });

  late double hide = 0;
  late double height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    if (expandedHeight != 93.h) {
      hide = shrinkOffset / expandedHeight;
      height = expandedHeight / (shrinkOffset + 1);
    } else {
      hide = 0;
      height = expandedHeight;
    }

    return CustomScrollView(
      physics: const NeverScrollableScrollPhysics(),
      slivers: [
        homeSliverAppBarWidget(
          context: context,
          expandedHeight: expandedHeight,
          child: Stack(
            fit: StackFit.expand,
            clipBehavior: Clip.none,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedContainer(
                      padding: MediaQuery.of(context).viewPadding.copyWith(
                        bottom: hide > .6 ? 0.h : 12.h,
                      ),
                      margin: EdgeInsets.only(
                        left: hide > .52 ? 250.w : 14.w,
                        right:hide > .52 ?68.w: 14.w,
                        top: hide > .6 ? 15.h : 70.h,
                      ),
                      duration: const Duration(seconds: 2),
                      alignment: hide > .6
                          ? const AlignmentDirectional(1, -1)
                          : const AlignmentDirectional(1, 1),
                      curve: Curves.easeOutQuint,
                      child: hide > .6
                          ? GestureDetector(
                        onTap: (){
                          navigateTo(context, SearchPage());
                        },
                            child: SvgPicture.asset(
                              AppIcons.homeSearch,
                            ),
                          )
                          : GestureDetector(
                        onTap: (){
                          navigateTo(context, SearchPage());
                        },
                            child: SearchBoxWidget(
                              height: 34.h,
                              width: ((MediaQuery.of(context).size.width) /
                                  (hide + (hide + 1)))
                                  .h,
                            ),
                          )),
                  Flexible(
                    child: AnimatedContainer(
                      duration: const Duration(seconds: 1),
                      curve: Curves.easeOutQuint,
                      alignment: const AlignmentDirectional(1, 1),
                      child:const HomeOffersWidget(),
                    ),
                  ),
                  10.h.verticalSpace,
                ],
              ),

            ],
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight + 48.h;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
