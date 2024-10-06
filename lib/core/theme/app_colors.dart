import 'package:flutter/material.dart';

/// This class contains all the colors of the app.
class AppColors {
  //Brand Colors
  static const Color greyColor = Color(0xff143959);
  static const Color scaffoldColor = Color(0xfffcfcfc);
  static const Color mainColorFont = Color(0xFF000000);
  static const Color secondaryColorFont = Color(0xff616161);
  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color transparent = Colors.transparent;
  static Color dangerColor = const Color(0xffD64545);
  static const Color primaryColor = Color(0xff1c5948);
  static Color secondaryColor = const Color(0xffeec087);
  static Color brownColor = const Color(0xffbf946f);
  static const Color errorColor500 = Color(0xFFEB4E3D);

  static const MaterialColor primarySwatch = MaterialColor(
    0xff1c5948,
    <int, Color>{
      900: Color(0xff1c5948),
      800: Color(0xff1f604e),
      700: Color(0xff216955),
      600: Color(0xff25765f),
      500: Color(0xff2f9276),
      400: Color(0xff329e80),
      300: Color(0xff33a384),
      200: Color(0xff38b18f),
      100: Color(0xff3aba96),
      50: Color(0xffa3c8be),
    },
  );

  static var darkSwatch = MaterialColor(
    greyColor.value,
    const {
      100: Color(0xffFAFAFA),
      200: Color(0xffeaeaea),
      300: Color(0xffe7e7e7),
    },
  );
  static const MaterialColor secondarySwatch = MaterialColor(
    0xFFBC2A23,
    <int, Color>{
      50: Color(0xFFF8E8E7),
      100: Color(0xFFF2D4D3),
      200: Color(0xFFE4AAA7),
      300: Color(0xFFD77F7B),
      400: Color(0xFFC9554F),
      500: Color(0xFFBC2A23),
      600: Color(0xFF962923),
      700: Color(0xFF712724),
      800: Color(0xFF3C2625),
      900: Color(0xFF413130),
    },
  );

  //grey
  static const MaterialColor greySwatch = MaterialColor(
    0xFFA39F9F,
    <int, Color>{
      50: Color(0xfff8f8f8),
      100: Color(0xFFF0EFEF),
      200: Color(0xFFE9E8E8),
      300: Color(0xFFDAD8D8),
      400: Color(0xFFC6C3C3),
      500: Color(0xFFA39F9F),
      600: Color(0xFF6b6b6b),
      700: Color(0xFF4D4949),
      800: Color(0xFF333232),
      900: Color(0xFF262525),
    },
  );

  //danger
  static const MaterialColor dangerSwatch = MaterialColor(
    0xFFEB4E3D,
    <int, Color>{
      50: Color(0xFFFEF6F0),
      100: Color(0xFFFEE8D8),
      200: Color(0xFFFDCBB2),
      300: Color(0xFFF9A78A),
      400: Color(0xFFF3846C),
      500: Color(0xFFEB4E3D),
      600: Color(0xFFCA2F2C),
      700: Color(0xFFA91E27),
      800: Color(0xFF881324),
      900: Color(0xFF432F2D),
    },
  );

  //success
  static const MaterialColor successSwatch = MaterialColor(
    0xFF35C75A,
    <int, Color>{
      50: Color(0xFFEAFDE7),
      100: Color(0xFFDCFCD7),
      200: Color(0xFFB2F9B0),
      300: Color(0xFF85EE8B),
      400: Color(0xFF63DD76),
      500: Color(0xFF35C75A),
      600: Color(0xFF26AB55),
      700: Color(0xFF1A8F4E),
      800: Color(0xFF107346),
      900: Color(0xFF304133),
    },
  );
}
