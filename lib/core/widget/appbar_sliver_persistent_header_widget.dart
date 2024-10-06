import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/core/widget/appbar_sliver_widget.dart';

class AppbarSliverPersistentHeaderWidget
    extends SliverPersistentHeaderDelegate {
  final String title;
  late double expandedHeight;
  final Widget child;

  AppbarSliverPersistentHeaderWidget({
    required this.expandedHeight,
    required this.title,
    required this.child,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return CustomScrollView(
      physics: const NeverScrollableScrollPhysics(),
      slivers: [
        appBarSliverWidget(
          title: title.toString(),
          expandedHeight: expandedHeight,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeOutQuint,
            alignment: const AlignmentDirectional(1, 1),
            child: child,
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
