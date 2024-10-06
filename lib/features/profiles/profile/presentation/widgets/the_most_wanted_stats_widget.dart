import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/core/extension/string.dart';
import 'package:gogreen/features/profiles/profile/presentation/riverpod/profile_riverpod.dart';
import 'name_and_color_of_the_product_statistics.dart';

class TheMostWantedStatsWidget extends ConsumerWidget {
  const TheMostWantedStatsWidget({super.key});

  @override
  Widget build(BuildContext context, ref) {
    var controller = ref.watch(statisticsProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        14.w.horizontalSpace,
        Flexible(
          child: SizedBox(
            height: 250.h,
            child: PieChart(
              PieChartData(
                centerSpaceRadius: 55.sp,
                sectionsSpace: 0,
                sections: [
                  ...controller.data.mostOrder.map(
                    (e) => PieChartSectionData(
                        color: e.color.toColor(),
                        value: e.value.toDouble(),
                        title: "${e.value}%",
                        radius: 30.r,
                        showTitle: false,
                        titleStyle: TextStyle(fontSize: 10.sp)),
                  ),
                ],
              ),
            ),
          ),
        ),
        40.w.horizontalSpace,
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...controller.data.mostOrder.map(
                (e) => NameAndColorOfTheProductStatisticsWidget(
                  title: e.name,
                  color: e.color.toColor(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
