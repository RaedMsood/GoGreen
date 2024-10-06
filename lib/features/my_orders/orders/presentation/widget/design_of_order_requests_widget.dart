import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/Core/theme/app_colors.dart';
import 'package:gogreen/core/theme/theme.dart';
import 'package:gogreen/core/widget/auto_size_text_widget.dart';
import 'package:gogreen/core/widget/gradient_widget.dart';
import 'package:gogreen/core/widget/online_images_widget.dart';
import 'package:gogreen/features/my_orders/orders/data/model/order_details/order_detail_company_and_product_model.dart';

class DesignOfOrderRequestsWidget extends StatelessWidget {
  final OrderDetailProductModel product;

  const DesignOfOrderRequestsWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        children: [
          OnlineImagesWidget(
            imageUrl: product.image.toString(),
            size: Size(80.w, 70.h),
            fit: BoxFit.contain,
            externalLink: true,
            logoWidth: 36.w,
            child: const Stack(
              clipBehavior: Clip.none,
              children: [
                /// Class Gradient
                GradientWidget(),
              ],
            ),
          ),
          8.w.horizontalSpace,
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeTextWidget(
                  text: product.name.toString(),
                  colorText: Colors.black87,
                  fontWeight: FontWeight.w700,
                  fontSize: 12.sp,
                  maxLines: 2,
                ),
                4.h.verticalSpace,
                AutoSizeTextWidget(
                  text: product.unit,
                  colorText: fontColor,
                  fontSize: 10.5.sp,
                  fontWeight: FontWeight.w400,
                  maxLines: 2,
                ),
                6.h.verticalSpace,
                AutoSizeTextWidget(
                  text: "Quantity:${product.quantity.toString()}",
                  colorText: AppColors.brownColor,
                  fontSize: 11.sp,
                  // fontWeight: FontWeight.w400,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
