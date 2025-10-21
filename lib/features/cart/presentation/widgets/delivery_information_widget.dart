import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gogreen/core/helpers/flash_bar_helper.dart';
import 'package:gogreen/core/theme/app_colors.dart';
import 'package:gogreen/core/constants/app_icons.dart';
import 'package:gogreen/core/widget/auto_size_text_widget.dart';
import 'package:gogreen/core/widget/buttons/default_button.dart';
import 'package:gogreen/core/widget/inputs/base_input.dart';
import 'package:gogreen/core/helpers/navigateTo.dart';
import 'package:gogreen/core/widget/show_modal_bottom_sheet_widget.dart';
import 'package:gogreen/features/address/data/models/address_model.dart';
import 'package:gogreen/features/address/presentation/pages/add_a_new_address_page.dart';
import 'package:gogreen/features/cart/presentation/riverpod/cart.riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'list_to_view_all_address_widget.dart';
import 'list_to_view_all_transportation_widget.dart';
import 'title_and_exit_button_for_bottom_sheet_widget.dart';

class DeliveryInformationWidget extends ConsumerWidget {
  const DeliveryInformationWidget({super.key});

  @override
  Widget build(BuildContext context, ref) {
    ref.watch(getConfirmOrderDataProvider);
    return Container(
      margin: EdgeInsets.all(14.sp),
      padding: EdgeInsets.all(8.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: ReactiveFormBuilder(
        form: () => CartRiverpodController.orderFormController.group,
        builder: (context, form, child) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeTextWidget(
                text: "Delivery Information",
                fontSize: 11.sp,
                colorText: AppColors.greySwatch.shade600,
              ),
              10.h.verticalSpace,
              Flexible(
                child: BaseInputWidget(
                  formControlName: 'address',
                  keyboardType: TextInputType.none,
                  validationMessages: {
                    ValidationMessage.required: (e) => 'Address is required',
                  },
                  cursorHeight: 0,
                  hintText: "Address",
                  hintFontSize: 11.5.sp,
                  hintTextColor: Colors.black,
                  onTap: (_) {
                    showModalBottomSheetWidget(
                      context: context,
                      page: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 14.w, vertical: 8.h),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const TitleAndExitButtonForBottomSheetWidget(
                              title: "Address",
                            ),
                            4.h.verticalSpace,
                            const ListToViewAllAddressWidget(),
                            12.h.verticalSpace,
                            DefaultButtonWidget(
                              text: "Add New Address",
                              borderRadius: 14.sp,
                              onPressed: () {
                                navigateTo(
                                  context,
                                  AddANewAddressPage(
                                    address: AddressModel.empty(),
                                    locationIsEmpty: true,
                                    onSuccess: () async {
                                      ref.refresh(getConfirmOrderDataProvider);
                                      Navigator.of(context).pop();
                                      showFlashBarSuccess(
                                        message:
                                            'New address added successfully',
                                        context: context,
                                      );
                                      return true;
                                    },
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  suffix: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: SvgPicture.asset(
                      AppIcons.arrowForward,
                    ),
                  ),
                ),
              ),
              Flexible(
                child: BaseInputWidget(
                  formControlName: 'has_vehicle',
                  keyboardType: TextInputType.none,
                  validationMessages: {
                    ValidationMessage.required: (e) =>
                        'Meaning of transportation is required',
                  },
                  cursorHeight: 0,
                  hintText: "Meaning of Transportation",
                  hintFontSize: 11.5.sp,
                  hintTextColor: Colors.black,
                  margin: const EdgeInsets.only(bottom: 0),
                  onTap: (_) {
                    showModalBottomSheetWidget(
                      context: context,
                      page: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 14.w, vertical: 8.h),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const TitleAndExitButtonForBottomSheetWidget(
                              title: "Meaning of Transportation",
                            ),
                            11.h.verticalSpace,
                            const ListToViewAllTransportationWidget(),
                          ],
                        ),
                      ),
                    );
                  },
                  suffix: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: SvgPicture.asset(
                      AppIcons.arrowForward,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
