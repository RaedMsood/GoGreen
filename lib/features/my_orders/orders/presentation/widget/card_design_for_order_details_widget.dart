import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/core/widget/auto_size_text_widget.dart';

class CardDesignForOrderDetailsWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;

  const CardDesignForOrderDetailsWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 18.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.sp),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.04),
            blurRadius: 1.r,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(8.sp),
            decoration: BoxDecoration(
              color: const Color(0xff378c74),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(
                  14.sp,
                ),
                topRight: Radius.circular(14.sp),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                  size: 18,
                ),
                6.w.horizontalSpace,
                AutoSizeTextWidget(
                  text: title,
                  colorText: Colors.white,
                  fontSize: 11.6.sp,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          ),

          /// Child
          Padding(
            padding: EdgeInsets.all(8.sp),
            child: child,
          ),
        ],
      ),
    );
  }
}
