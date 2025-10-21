import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/core/extension/string.dart';
import 'package:gogreen/core/theme/app_colors.dart';
import 'package:gogreen/core/widget/auto_size_text_widget.dart';
import 'package:gogreen/core/helpers/navigateTo.dart';
import 'package:gogreen/core/widget/online_images_widget.dart';
import 'package:gogreen/features/home/notifications/data/model/model.dart';
import 'package:gogreen/features/orders/presentation/pages/order_details_page.dart';

class NotificationCardWidget extends StatelessWidget {
  final NotificationModel notification;

  const NotificationCardWidget({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //  check if the url has order
        if (notification.url.contains('order')) {
          //get the order id
          var orderId = notification.url.split('order/').last;
          //navigate to the order details
          navigateTo(context, OrderDetailsPage(id: int.parse(orderId)));
        }
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 24.h),
        color: AppColors.whiteColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100.sp),
                  child: OnlineImagesWidget(
                    imageUrl: "",
                    size: Size(58.w, 54.h),
                    logoWidth: 26.w,
                  ),
                ),
                14.w.horizontalSpace,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      4.h.verticalSpace,
                      AutoSizeTextWidget(
                        text: notification.title.toString(),
                        fontWeight: FontWeight.w700,
                        fontSize: 13.4.sp,
                        maxLines: 2,
                      ),
                      7.h.verticalSpace,
                      AutoSizeTextWidget(
                        text: dayHour("${notification.createdAt}"),
                        colorText: AppColors.greySwatch.shade600,
                        fontSize: 11.sp,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (notification.content != null && notification.content.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(top: 14.h),
                child: AutoSizeTextWidget(
                  text: notification.content.toString(),
                  colorText: AppColors.greySwatch.shade600,
                  fontSize: 11.sp,
                  maxLines: 8,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
