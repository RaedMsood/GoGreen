import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gogreen/Core/theme/app_colors.dart';


ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  primarySwatch: AppColors.primarySwatch,
  splashColor: AppColors.primarySwatch.shade50.withOpacity(.6),
  highlightColor: AppColors.primarySwatch.shade50.withOpacity(.4),

  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0.0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  ),
  fontFamily: 'PlusJakartaSans',
);
