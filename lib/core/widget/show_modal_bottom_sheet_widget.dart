import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showModalBottomSheetWidget({
  required BuildContext context,
  required Widget page,
  Color? backgroundColor,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor:backgroundColor?? Colors.white,
    builder: (context) =>  Padding(
      padding:  EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: page,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(14.sp),
        topRight: Radius.circular(14.sp),
      ),
    ),
  );
}
