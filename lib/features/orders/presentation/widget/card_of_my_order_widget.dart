import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/Core/theme/app_colors.dart';
import 'package:gogreen/core/extension/string.dart';
import 'package:gogreen/core/widget/auto_size_text_widget.dart';
import 'package:gogreen/core/widget/gradient_widget.dart';
import 'package:gogreen/core/helpers/navigateTo.dart';
import 'package:gogreen/core/widget/online_images_widget.dart';
import 'package:gogreen/features/orders/presentation/pages/order_details_page.dart';

import '../../data/model/order_model.dart';

class CardOfMyOrderWidget extends StatelessWidget {
  final OrderModel order;
  final int numberOfItem;

  const CardOfMyOrderWidget(
      {super.key, required this.order, required this.numberOfItem});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigateTo(context, OrderDetailsPage(id: order.id));
      },
      child: Container(
        padding: EdgeInsets.all(8.sp),
        margin: EdgeInsets.only(bottom: 13.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.sp),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.04),
              blurRadius: 1.r,
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AutoSizeTextWidget(
                  text: '# ${order.transactionId.toString()}',
                  colorText: AppColors.primaryColor,
                  fontSize: 10.2.sp,
                ),
                8.w.horizontalSpace,
                Flexible(
                  child: AutoSizeTextWidget(
                    text: dayHour(order.date),
                    colorText: AppColors.primaryColor,
                    fontSize: 10.1.sp,
                    minFontSize: 11,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
            10.h.verticalSpace,
            Row(
              children: [
                OnlineImagesWidget(
                  imageUrl: order.company.image.toString(),
                  size: Size(85.w, 74.h),
                  fit: BoxFit.contain,
                  externalLink: true,
                  child: const Stack(
                    clipBehavior: Clip.none,
                    children: [
                      /// Class Gradient
                      GradientWidget(),
                    ],
                  ),
                ),
                10.w.horizontalSpace,
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeTextWidget(
                        text: order.company.name.toString(),
                        colorText: Colors.black87,
                        fontSize: 12.2.sp,
                        fontWeight: FontWeight.w700,
                        maxLines: 3,
                      ),
                      6.h.verticalSpace,
                      AutoSizeTextWidget(
                        text: "${order.numberOfProducts.toString()}  items",
                        colorText: AppColors.greySwatch.shade600,
                        fontSize: 10.sp,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            8.h.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AutoSizeTextWidget(
                  text: "\$${order.total.toString()}",
                  colorText: AppColors.primarySwatch.shade900,
                  fontSize: 10.5.sp,
                  fontWeight: FontWeight.w700,
                ),
                Container(
                  width: 140.w,
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 9.h),
                  decoration: BoxDecoration(
                    color: order.status.backgroundColor.toColor(),
                    borderRadius: BorderRadius.circular(8.sp),
                  ),
                  alignment: Alignment.center,
                  child: AutoSizeTextWidget(
                    text: order.status.name,
                    colorText: order.status.textColor.toColor(),
                    fontSize: 9.6.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
