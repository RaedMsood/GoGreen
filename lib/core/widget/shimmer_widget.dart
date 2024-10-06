import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/Core/theme/app_colors.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  final Widget child;
 final Color? baseColor;
    const ShimmerWidget({super.key, required this.child,this.baseColor});

  @override
  Widget build(BuildContext context) {

    return Shimmer.fromColors(

      baseColor: baseColor?? AppColors.primarySwatch.shade300.withOpacity(.15),
      highlightColor: AppColors.primarySwatch.shade50.withOpacity(.14),
      child: child,
    );
  }
}
class ShimmerPlaceholderWidget extends StatelessWidget {
  final double? width;
  final double? height;

  const ShimmerPlaceholderWidget(
      {super.key,  this.width,  this.height});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.primarySwatch.shade300.withOpacity(.15),
      highlightColor: AppColors.primarySwatch.shade50.withOpacity(.14),
      child: Container(
          width: width??double.infinity,
          height: height??100.h,
          decoration: BoxDecoration(
            color: AppColors.primarySwatch.shade100,
            borderRadius: BorderRadius.circular(8),
          )),
    );
  }
}

