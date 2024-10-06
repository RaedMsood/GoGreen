import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/Core/theme/app_colors.dart';
import 'package:gogreen/core/states/error.state.dart';
import 'package:gogreen/core/states/ui.state.dart';
import 'package:gogreen/core/states/view.state.dart';
import 'package:gogreen/core/widget/appbar_sliver_persistent_header_widget.dart';
import 'package:gogreen/core/widget/auto_size_text_widget.dart';
import 'package:gogreen/core/widget/bottomNavbar/bottom_navigation_bar_widget.dart';
import 'package:gogreen/core/widget/inputs/text_form_field.dart';
import 'package:gogreen/core/helpers/navigateTo.dart';
import 'package:gogreen/features/cart/presentation/riverpod/cart.riverpod.dart';
import 'package:gogreen/features/cart/presentation/widgets/delivery_information_widget.dart';
import 'package:gogreen/features/cart/presentation/widgets/discount_coupon_widget.dart';
import 'package:gogreen/features/cart/presentation/widgets/list_to_view_all_payment_method_widget.dart';
import 'package:gogreen/features/cart/presentation/widgets/order_success_dialog_widget.dart';
import 'package:gogreen/features/cart/presentation/widgets/shimmer_to_confirm_order_widget.dart';
import 'package:gogreen/features/cart/presentation/widgets/total_and_confirm_order_bottom_bar_widget.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ConfirmOrderPage extends ConsumerWidget {
  final String total;

  ConfirmOrderPage({super.key, required this.total});

  TextEditingController addANote = TextEditingController();

  TextEditingController discountCoupon = TextEditingController();

  @override
  Widget build(BuildContext context, ref) {
    var controller = ref.watch(getConfirmOrderDataProvider);
    var cartController = ref.watch(cartProvider);

    return Scaffold(
      body: ReactiveFormBuilder(
        form: () => CartRiverpodController.orderFormController.group,
        builder: (context, form, child) {
          return CustomScrollView(
            slivers: [
              SliverPersistentHeader(
                pinned: true,
                floating: false,
                delegate: AppbarSliverPersistentHeaderWidget(
                  title: "Confirm Order",
                  expandedHeight: 270.h,
                  child: Padding(
                    padding: EdgeInsets.only(top: 80.h),
                    child: const DeliveryInformationWidget(),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(14.sp),
                  child: UIState(
                    state: controller.viewState,
                    loadingState: const ShimmerToConfirmOrderWidget(),
                    errorState: Center(
                      child: ErrorState.container(
                        error: controller.errorModel,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        2.h.verticalSpace,

                        AutoSizeTextWidget(
                          text: "Choose your payment method",
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                        ),
                        10.h.verticalSpace,

                        if (form.control('payment_method').invalid)
                          StreamBuilder(
                            stream: form.control('payment_method').touchChanges,
                            builder: (context, snapshot) {
                              if (snapshot.data == true) {
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 8.h),
                                  child: AutoSizeTextWidget(
                                    text: "Please chose a payment method",
                                    fontSize: 11.5.sp,
                                    colorText: AppColors.errorColor500,
                                  ),
                                );
                              }
                              return const SizedBox();
                            },
                          ),

                        /// Class View All Payment Method
                        const ListToViewAllPaymentMethodWidget(),

                        AutoSizeTextWidget(
                          text: "Note",
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                        ),
                        10.h.verticalSpace,
                        TextFormFieldWidget(
                          type: TextInputType.multiline,
                          controller: addANote,
                          fillColor: AppColors.greySwatch.shade50,
                          hintFontSize: 10.sp,
                          hintText: "Note",
                          maxLine: 6,
                        ),
                        DiscountCouponWidget(
                          discountCoupon: discountCoupon.text,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: UIState(
        state: controller.viewState,
        loadingState: const SizedBox(),
        errorState: const SizedBox(),
        child: TotalAndConfirmOrderBottomBarWidget(
          total: total.toString(),
          isLoading: cartController.viewState == ViewState.loading,
          onPressed: () {
            ref.read(cartProvider.notifier).send(
                context: context,
                note: addANote.text,
                onSuccess: () {
                  CompleteOrder.successDialog(context, ref);
                });
          },
        ),
      ),
    );
  }
}

class CompleteOrder {
  static successDialog(BuildContext context, ref) {
    showDialog(
      useSafeArea: true,
      context: context,
      builder: (context) {
        return const Dialog(
          alignment: Alignment.center,
          backgroundColor: Colors.transparent,
          child: OrderSuccessDialogWidget(),
        );
      },
    ).then((v) {
      ref.read(activeIndexProvider.notifier).state = 0;
      navigateAndFinish(context, const BottomNavigationBarWidget());
    });
  }
}
