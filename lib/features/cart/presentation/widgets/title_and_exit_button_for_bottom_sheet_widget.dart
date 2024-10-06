import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gogreen/core/constants/app_icons.dart';
import 'package:gogreen/core/theme/buttons.dart';
import 'package:gogreen/core/widget/auto_size_text_widget.dart';

class TitleAndExitButtonForBottomSheetWidget extends StatelessWidget {
  final String title;
  const TitleAndExitButtonForBottomSheetWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AutoSizeTextWidget(
          text: title,
          fontSize: 13.sp,
        ),
        IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: WingsButtons.circleStyle,
          icon: SvgPicture.asset(
            AppIcons.close,
            height: 16.r,
            width: 16.r,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
