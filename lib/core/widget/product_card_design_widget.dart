import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gogreen/core/theme/app_colors.dart';
import 'package:gogreen/core/theme/buttons.dart';
import 'package:gogreen/core/widget/buttons/small_Icon_button_widget.dart';
import 'package:gogreen/core/constants/app_icons.dart';
import 'package:gogreen/core/widget/auto_size_text_widget.dart';
import 'package:gogreen/core/widget/gradient_widget.dart';
import 'package:gogreen/core/widget/online_images_widget.dart';
import 'photo_view_dialog_widget.dart';

class ProductCardDesignWidget extends ConsumerWidget {
  final String image, name, price, unit;
  final int quantity;
  final VoidCallback increment;
  final VoidCallback decrement;
  final Function()? clickOnTheImage;

  const ProductCardDesignWidget({
    super.key,
    required this.image,
    required this.name,
    required this.price,
    required this.unit,
    required this.quantity,
    required this.increment,
    required this.decrement,
    this.clickOnTheImage,
  });

  @override
  Widget build(BuildContext context, ref) {
    return Container(
      margin: EdgeInsets.only(bottom: 14.h),
      padding: EdgeInsets.all(8.sp),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.04),
            blurRadius: 1.r,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          GestureDetector(
            onTap: clickOnTheImage,
            child: OnlineImagesWidget(
              imageUrl: image,
              size: Size(105.w, 90.h),
              fit: BoxFit.contain,
              externalLink: true,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  /// Class Gradient
                  const GradientWidget(),
                  PositionedDirectional(
                    top: -9.r,
                    start: -18,
                    child: TextButton(
                      onPressed: () {
                        PhotoViewDialogWidget.show(context, image);
                      },
                      style: WingsButtons.circleStyle,
                      child: SvgPicture.asset(
                        height: 15.r,
                        width: 15.r,
                        AppIcons.zoom,
                        allowDrawingOutsideViewBox: true,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          8.w.horizontalSpace,
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeTextWidget(
                  text: name,
                  fontSize: 13.4.sp,
                  maxLines: 2,
                  minFontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
                10.h.verticalSpace,
                AutoSizeTextWidget(
                  text: unit,
                  colorText: AppColors.greySwatch.shade600,
                  fontSize: 10.5.sp,
                  maxLines: 2,
                ),
                12.h.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: AutoSizeTextWidget(
                        text: "\$${price.toString()}",
                        colorText: AppColors.brownColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        minFontSize: 12,
                      ),
                    ),
                    4.w.horizontalSpace,
                    Padding(
                      padding: EdgeInsets.only(top: 3.h),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        textDirection: TextDirection.rtl,
                        children: [
                          SmallIconButtonWidget(
                            icon: AppIcons.plus,
                            onPressed: increment,
                          ),
                          if (quantity > 0) ...[
                            6.w.horizontalSpace,
                            AutoSizeTextWidget(
                              text: quantity.toString(),
                              fontSize: 12.5.sp,
                              textAlign: TextAlign.center,
                            ),
                            6.w.horizontalSpace,
                            SmallIconButtonWidget(
                              icon: AppIcons.minus,
                              onPressed: decrement,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
