import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/core/theme/app_colors.dart';
import 'package:gogreen/core/widget/buttons/default_button.dart';
import 'package:gogreen/core/helpers/navigateTo.dart';
import 'package:gogreen/features/cart/presentation/pages/cart_page.dart';
import 'package:gogreen/features/cart/presentation/riverpod/cart.riverpod.dart';

class ViewCartButtonForCompanyDetailsWidget extends ConsumerWidget {
  final int companyId;

  const ViewCartButtonForCompanyDetailsWidget(
      {super.key, required this.companyId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    var state = ref.watch(cartProvider);
    // var index = state.data.companyId.indexWhere(
    //       (element) => element. == companyId,
    // );

    return state.company!.id != companyId
        ? const SizedBox()
        : Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24.r),
                topRight: Radius.circular(24.r),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.09),
                  blurRadius: 4.r,
                ),
              ],
            ),
            child: DefaultButtonWidget(
              text: "Show Cart",
              onPressed: () {
                navigateTo(context, const CartPage());
              },
            ),
          );
  }
}
