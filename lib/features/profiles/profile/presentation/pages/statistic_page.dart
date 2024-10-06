import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/Core/theme/app_colors.dart';
import 'package:gogreen/core/extension/string.dart';
import 'package:gogreen/core/states/error.state.dart';
import 'package:gogreen/core/states/ui.state.dart';
import 'package:gogreen/core/widget/appbar_widget.dart';
import 'package:gogreen/core/widget/auto_size_text_widget.dart';
import 'package:gogreen/features/profiles/profile/presentation/riverpod/profile_riverpod.dart';
import 'package:gogreen/features/profiles/profile/presentation/widgets/shimmer_stats_widget.dart';
import 'package:gogreen/features/profiles/profile/presentation/widgets/the_most_wanted_stats_widget.dart';

class StatisticsPage extends ConsumerWidget {
  const StatisticsPage({super.key}) : super();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var controller = ref.watch(statisticsProvider);
    return Scaffold(
      appBar: AppBarWidget(
        title: "Stats",
      ),
      body: UIState(
        state: controller.viewState,
        loadingState: const ShimmerStatsWidget(),
        errorState: Center(
          child: ErrorState.container(error: controller.errorModel),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(14.sp),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeTextWidget(
                text: "Total products",
                fontSize: 15.8.sp,
              ),
              40.h.verticalSpace,

              Container(
                width: double.infinity,
                height: 250.h,
                margin: EdgeInsets.only(bottom: 40.h),
                child: BarChart(
                  BarChartData(
                    borderData: FlBorderData(
                      border: const Border(
                        top: BorderSide.none,
                        right: BorderSide.none,
                        left: BorderSide.none,
                        bottom: BorderSide(width: 1),
                      ),
                    ),
                    groupsSpace: 10,
                    titlesData: FlTitlesData(
                      show: true,
                      rightTitles: const AxisTitles(),
                      topTitles: const AxisTitles(),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              return AutoSizeTextWidget(
                                text: controller
                                    .data.productsCount[value.toInt()].name,
                                fontSize: 10.8.sp,
                              );
                            }),
                      ),
                    ),
                    barGroups: [
                      ...controller.data.productsCount.map(
                        (e) => BarChartGroupData(
                          x: 0 + controller.data.productsCount.indexOf(e),
                          barRods: [
                            BarChartRodData(
                              toY: e.value.toDouble(),
                              width: 15,
                              color: e.color.toColor(),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(5),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: false,
                      getDrawingHorizontalLine: (value) {
                        return const FlLine(
                          color: Color(0xffC0CDD9),
                          strokeWidth: 1,
                        );
                      },
                    ),
                  ),
                ),
              ),
              AutoSizeTextWidget(
                text: "The most wanted",
                fontSize: 15.8.sp,
              ),

              /// Class the most wanted stats
              const TheMostWantedStatsWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
