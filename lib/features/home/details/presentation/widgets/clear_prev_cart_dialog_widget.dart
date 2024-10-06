import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/core/theme/app_colors.dart';
import 'package:gogreen/core/widget/auto_size_text_widget.dart';
import 'package:gogreen/core/widget/buttons/default_button.dart';

class ClearPrevCartDialogWidget {
  static Future<bool> show(
      BuildContext context, Future<bool> Function() onPress) {
    return Future.delayed(Duration.zero, () async {
      return await showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(14.sp),
                  topRight: Radius.circular(14.sp),
                ),
              ),
              padding: EdgeInsets.all(14.sp),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AutoSizeTextWidget(
                    text: "There are items in the cart",
                    fontSize: 15.5.sp,
                    colorText: AppColors.dangerColor.withOpacity(.95),
                    fontWeight: FontWeight.w700,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  ),
                  8.h.verticalSpace,
                  AutoSizeTextWidget(
                    text:
                        "There are items in the cart from another store, do you want to delete them?",
                    fontSize: 12.6.sp,
                    colorText: AppColors.greySwatch.shade800,
                    textAlign: TextAlign.center,
                    maxLines: 3,
                  ),
                  18.h.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: DefaultButtonWidget(
                          text: 'No',
                          borderRadius: 20.sp,
                          gradient: false,
                          background: AppColors.greySwatch.shade50,
                          textColor: AppColors.greySwatch.shade800,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      14.w.horizontalSpace,
                      Expanded(
                        child: DefaultButtonWidget(
                          text: 'Yes',
                          borderRadius: 20.sp,
                          gradient: false,
                          background: AppColors.dangerColor.withOpacity(.95),
                          onPressed: () async {
                            var result = await onPress();
                            Navigator.pop(context, result);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          });
    });
  }
}
