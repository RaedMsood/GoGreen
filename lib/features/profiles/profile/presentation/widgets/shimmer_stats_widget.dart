import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/core/theme/app_colors.dart';
import 'package:gogreen/core/widget/auto_size_text_widget.dart';
import 'package:gogreen/core/widget/shimmer_widget.dart';

class ShimmerStatsWidget extends StatelessWidget {
  const ShimmerStatsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(14.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerPlaceholderWidget(
            width: 160.w,
            height: 18.h,
          ),
          24.h.verticalSpace,
          ShimmerWidget(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.only(top: 10.h),
              height: 240.h,
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
                          return const AutoSizeTextWidget(text: '------');
                        },
                      ),
                    ),
                  ),
                  // add bars
                  barGroups: [
                    BarChartGroupData(
                      x: 1,
                      barRods: [
                        BarChartRodData(
                          toY: 10,
                          width: 15,
                          color: AppColors.primaryColor,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5),
                          ),
                        ),
                      ],
                    ),
                    BarChartGroupData(
                      x: 2,
                      barRods: [
                        BarChartRodData(
                          toY: 8,
                          width: 15,
                          color: AppColors.primaryColor,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5),
                          ),
                        ),
                      ],
                    ),
                    BarChartGroupData(
                      x: 3,
                      barRods: [
                        BarChartRodData(
                          toY: 6,
                          width: 15,
                          color: AppColors.primaryColor,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5),
                          ),
                        ),
                      ],
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
          ),
          24.h.verticalSpace,
          ShimmerPlaceholderWidget(
            width: 180.w,
            height: 18.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              14.w.horizontalSpace,
              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  height: 200.h,
                  child: ShimmerWidget(
                    child: PieChart(
                      PieChartData(
                        centerSpaceRadius: 40.sp,
                        sectionsSpace: 0,
                        sections: [
                          PieChartSectionData(
                            color: AppColors.primarySwatch.shade800,
                            value: 400,
                            title: '40%',
                            radius: 26.r,
                            showTitle: false,
                          ),
                          PieChartSectionData(
                            color: AppColors.primarySwatch.withOpacity(.5),
                            value: 250,
                            title: '50%',
                            radius: 26.r,
                            showTitle: false,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              40.w.horizontalSpace,
              Flexible(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                      6,
                      (index) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 8.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ShimmerWidget(
                                child: Container(
                                  width: 24.w,
                                  height: 8.h,
                                  color: AppColors.primarySwatch.shade100,
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Flexible(
                                child: ShimmerPlaceholderWidget(
                                  width: 80.w,
                                  height: 11.h,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
