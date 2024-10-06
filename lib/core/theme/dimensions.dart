import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


/// This class contains all the general dimensions of the app.
class AppDimensions {
  static double get buttonBorderRadius => 28.r;
  static double get secondaryButtonBorderRadius => 12.r;
  static double get horizontalPadding => 18.w;
  static double _statusBarHeight = 0.0;
  static double get statusBarHeight => _statusBarHeight;

  static void init(BuildContext context) {
    _statusBarHeight = MediaQuery.of(context).padding.top;
  }
}
