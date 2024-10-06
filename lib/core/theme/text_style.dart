import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_fonts.dart';
import 'app_colors.dart';

/// This class contains all the text styles of the app.
class AppTextStyle {
  static const FontWeight boldFontWeight = FontWeight.w700;
  static const FontWeight semiBoldFontWeight = FontWeight.w600;
  static const FontWeight mediumFontWeight = FontWeight.w500;
  static const FontWeight regularFontWeight = FontWeight.w400;
  static const FontWeight lightFontWeight = FontWeight.w300;

  static const Color mainColorFont = AppColors.mainColorFont;

  static Widget wrapAppToStopTextScaleFactor(
      {required Widget child, required BuildContext context}) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaleFactor: 1.0,

        /// This is a temporary solution to fix the problem of the Animation for modal bottom sheet stops working on some devices
        /// see: https://github.com/flutter/flutter/pull/121132
        /// TODO: Remove this when flutter team fix this issue and release a new version
        accessibleNavigation: false,
      ),
      child: child,
    );
  }

  static Widget wrapAppToRemoveFirstAndLastLineHeight({required Widget child}) {
    return DefaultTextHeightBehavior(
      textHeightBehavior: AppTextStyle.removeFirstAndLastLineHeight,
      child: child,
    );
  }

  static TextHeightBehavior get removeFirstAndLastLineHeight =>
      const TextHeightBehavior(
        applyHeightToFirstAscent: false,
        applyHeightToLastDescent: false,
      );

  static TextStyle _baseStyleFont({
    required FontWeight fontWeight,
    required double fontSize,
  }) =>
      TextStyle(
        fontFamily: AppFonts.fontFamily,
        fontWeight: fontWeight,
        fontSize: fontSize.sp,
        height:1.3,// _FontHeightConstants.getHeight(fontSize, fontWeight),
        color: mainColorFont,
      );
// 8
  static TextStyle get bold8 => _baseStyleFont(
        fontWeight: boldFontWeight,
        fontSize: 8.0,
      );

  static TextStyle get semiBold8 => _baseStyleFont(
        fontWeight: semiBoldFontWeight,
        fontSize: 8.0,
      );

  static TextStyle get regular8 => _baseStyleFont(
        fontWeight: regularFontWeight,
        fontSize: 8.0,
      );

  static TextStyle get light8 => _baseStyleFont(
        fontWeight: lightFontWeight,
        fontSize: 8.0,
      );

  static TextStyle get medium8 => _baseStyleFont(
        fontWeight: mediumFontWeight,
        fontSize: 8.0,
      );

// 10
  static TextStyle get bold10 => _baseStyleFont(
        fontWeight: boldFontWeight,
        fontSize: 10.0,
      );

  static TextStyle get semiBold10 => _baseStyleFont(
        fontWeight: semiBoldFontWeight,
        fontSize: 10.0,
      );

  static TextStyle get regular10 => _baseStyleFont(
        fontWeight: regularFontWeight,
        fontSize: 10.0,
      );

  static TextStyle get light10 => _baseStyleFont(
        fontWeight: lightFontWeight,
        fontSize: 10.0,
      );

  static TextStyle get medium10 => _baseStyleFont(
        fontWeight: mediumFontWeight,
        fontSize: 10.0,
      );

// 12
  static TextStyle get bold12 => _baseStyleFont(
        fontWeight: boldFontWeight,
        fontSize: 12.0,
      );

  static TextStyle get semiBold12 => _baseStyleFont(
        fontWeight: semiBoldFontWeight,
        fontSize: 12.0,
      );

  static TextStyle get regular12 => _baseStyleFont(
        fontWeight: regularFontWeight,
        fontSize: 12.0,
      );

  static TextStyle get light12 => _baseStyleFont(
        fontWeight: lightFontWeight,
        fontSize: 12.0,
      );

  static TextStyle get medium12 => _baseStyleFont(
        fontWeight: mediumFontWeight,
        fontSize: 12.0,
      );

// 14
  static TextStyle get bold14 => _baseStyleFont(
        fontWeight: boldFontWeight,
        fontSize: 14.0,
      );
  static TextStyle get semiBold14 => _baseStyleFont(
        fontWeight: semiBoldFontWeight,
        fontSize: 14.0,
      );

  static TextStyle get regular14 => _baseStyleFont(
        fontWeight: regularFontWeight,
        fontSize: 14.0,
      );

  static TextStyle get light14 => _baseStyleFont(
        fontWeight: lightFontWeight,
        fontSize: 14.0,
      );

  static TextStyle get medium14 => _baseStyleFont(
        fontWeight: mediumFontWeight,
        fontSize: 14.0,
      );

// 16
  static TextStyle get bold16 => _baseStyleFont(
        fontWeight: boldFontWeight,
        fontSize: 16.0,

      );
  static TextStyle get semiBold16 => _baseStyleFont(
        fontWeight: semiBoldFontWeight,
        fontSize: 16.0,
      );

  static TextStyle get regular16 => _baseStyleFont(
        fontWeight: regularFontWeight,
        fontSize: 16.0,
      );

  static TextStyle get light16 => _baseStyleFont(
        fontWeight: lightFontWeight,
        fontSize: 16.0,
      );

  static TextStyle get medium16 => _baseStyleFont(
        fontWeight: mediumFontWeight,
        fontSize: 16.0,
      );

// 18
  static TextStyle get bold18 => _baseStyleFont(
        fontWeight: boldFontWeight,
        fontSize: 18.0,
      );
  static TextStyle get semiBold18 => _baseStyleFont(
        fontWeight: semiBoldFontWeight,
        fontSize: 18.0,
      );

  static TextStyle get regular18 => _baseStyleFont(
        fontWeight: regularFontWeight,
        fontSize: 18.0,
      );

  static TextStyle get light18 => _baseStyleFont(
        fontWeight: lightFontWeight,
        fontSize: 18.0,
      );

  static TextStyle get medium18 => _baseStyleFont(
        fontWeight: mediumFontWeight,
        fontSize: 18.0,
      );

// 20
  static TextStyle get bold20 => _baseStyleFont(
        fontWeight: boldFontWeight,
        fontSize: 20.0,
      );

  static TextStyle get bold25 => _baseStyleFont(
        fontWeight: boldFontWeight,
        fontSize: 25.0,
      );

  static TextStyle get semiBold20 => _baseStyleFont(
        fontWeight: semiBoldFontWeight,
        fontSize: 20.0,
      );

  static TextStyle get regular20 => _baseStyleFont(
        fontWeight: regularFontWeight,
        fontSize: 20.0,
      );

  static TextStyle get light20 => _baseStyleFont(
        fontWeight: lightFontWeight,
        fontSize: 20.0,
      );

  static TextStyle get medium20 => _baseStyleFont(
        fontWeight: mediumFontWeight,
        fontSize: 20.0,
      );

//
  static const List<_FontHeightConstants> _listFontHeightConstants = [
    // 12-8
    _FontHeightConstants(
      fontWeight: boldFontWeight,
      from: 8,
      to: 12,
      height: 24,
    ),
    _FontHeightConstants(
      fontWeight: semiBoldFontWeight,
      from: 8,
      to: 12,
      height: 24,
    ),
    _FontHeightConstants(
      fontWeight: mediumFontWeight,
      from: 8,
      to: 12,
      height: 20,
    ),
    _FontHeightConstants(
      fontWeight: regularFontWeight,
      from: 8,
      to: 12,
      height: 20,
    ),
    _FontHeightConstants(
      fontWeight: lightFontWeight,
      from: 8,
      to: 12,
      height: 20,
    ),

    // 15-13

    _FontHeightConstants(
      fontWeight: boldFontWeight,
      from: 13,
      to: 15,
      height: 30,
    ),
    _FontHeightConstants(
      fontWeight: semiBoldFontWeight,
      from: 13,
      to: 15,
      height: 30,
    ),
    _FontHeightConstants(
      fontWeight: mediumFontWeight,
      from: 13,
      to: 15,
      height: 26,
    ),
    _FontHeightConstants(
      fontWeight: regularFontWeight,
      from: 13,
      to: 15,
      height: 26,
    ),
    _FontHeightConstants(
      fontWeight: lightFontWeight,
      from: 13,
      to: 15,
      height: 26,
    ),

    // 19-16

    _FontHeightConstants(
      fontWeight: boldFontWeight,
      from: 16,
      to: 19,
      height: 36,
    ),
    _FontHeightConstants(
      fontWeight: semiBoldFontWeight,
      from: 16,
      to: 19,
      height: 36,
    ),
    _FontHeightConstants(
      fontWeight: mediumFontWeight,
      from: 16,
      to: 19,
      height: 30,
    ),
    _FontHeightConstants(
      fontWeight: regularFontWeight,
      from: 16,
      to: 19,
      height: 30,
    ),
    _FontHeightConstants(
      fontWeight: lightFontWeight,
      from: 16,
      to: 19,
      height: 30,
    ),

    // 24-20

    _FontHeightConstants(
      fontWeight: boldFontWeight,
      from: 20,
      to: 24,
      height: 46,
    ),
    _FontHeightConstants(
      fontWeight: semiBoldFontWeight,
      from: 20,
      to: 24,
      height: 46,
    ),
    _FontHeightConstants(
      fontWeight: mediumFontWeight,
      from: 20,
      to: 24,
      height: 40,
    ),
    _FontHeightConstants(
      fontWeight: regularFontWeight,
      from: 20,
      to: 24,
      height: 40,
    ),
    _FontHeightConstants(
      fontWeight: lightFontWeight,
      from: 20,
      to: 24,
      height: 46,
    ),
  ];
}

class _FontHeightConstants {
  final double from;
  final double to;
  final double height;
  final FontWeight fontWeight;
  const _FontHeightConstants({
    required this.from,
    required this.to,
    required this.height,
    required this.fontWeight,
  });

  bool isBetween(double value) {
    return value >= from && value <= to;
  }

  double getValue(double fontSize) {
    return height / fontSize;
  }

  static double getHeight(double fontSize, FontWeight fontWeight) {
    for (final _FontHeightConstants constants
        in AppTextStyle._listFontHeightConstants) {
      if (constants.fontWeight == fontWeight && constants.isBetween(fontSize)) {
        return constants.getValue(fontSize);
      }
    }
    return 1.0;
  }
}
