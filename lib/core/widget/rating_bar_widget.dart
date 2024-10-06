import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RatingBarWidget extends StatelessWidget {
  final double evaluation;
  int? length;
  double? itemSize;
  Color? unratedColor;
  Color? labeledColor;

    RatingBarWidget({
    super.key,
    required this.evaluation,
    this.length,
    this.itemSize,
    this.unratedColor,
    this.labeledColor,
  });

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: evaluation,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      ignoreGestures: true,
      itemCount: length ?? 5,
      itemSize: itemSize ?? 14.sp,
      itemPadding: EdgeInsets.only(right: 2.w),
      unratedColor: unratedColor ?? Colors.grey[300],
      itemBuilder: (context, _) => Icon(
        Icons.star_rounded,
        color: labeledColor ?? const Color(0xfffea324),
      ),
      onRatingUpdate: (rating) {},
    );
  }
}
