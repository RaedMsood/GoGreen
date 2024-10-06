import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gogreen/core/constants/app_icons.dart';
import 'package:gogreen/core/widget/inputs/base_input.dart';
import 'package:gogreen/core/widget/show_modal_bottom_sheet_widget.dart';
import 'package:gogreen/features/address/data/models/address_model.dart';
import 'package:gogreen/features/address/presentation/riverpod/address_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'cities_input_widget.dart';
import 'district_input_widget.dart';
import 'list_to_view_all_states_widget.dart';

class AddANewAddressWidget extends ConsumerStatefulWidget {
  final AddressModel address;

  const AddANewAddressWidget({
    super.key,
    required this.address,
  });

  @override
  ConsumerState<AddANewAddressWidget> createState() =>
      _AddANewAddressWidgetState();
}

class _AddANewAddressWidgetState extends ConsumerState<AddANewAddressWidget> {
  @override
  Widget build(BuildContext context) {
    ref.watch(addressStoreProvider(widget.address).notifier);
    ref.watch(citiesProvider);
    ref.watch(districtsProvider);
    ref.watch(statesProvider);

    return ReactiveFormBuilder(
      form: () =>
          ref.read(addressStoreProvider(widget.address).notifier).form.group,
      builder: (context, form, child) {
        return Column(
          children: [
            2.h.verticalSpace,
            BaseInputWidget(
              formControlName: 'state_name',
              keyboardType: TextInputType.none,
              validationMessages: {
                ValidationMessage.required: (e) => 'State is required',
              },
              cursorHeight: 0,
              label: "State",
              labelFontSize: 12.6.sp,
              labelTextColor: Colors.black,
              fontSize: 13.sp,
              onTap: (i) {
                showModalBottomSheetWidget(
                  context: context,
                  page: ListToViewAllStatesWidget(
                    address: widget.address,
                  ),
                );
              },
              suffix: Padding(
                padding: EdgeInsets.symmetric(vertical: 14.h),
                child: SvgPicture.asset(
                  AppIcons.arrowDown,
                  height: 18.h,
                ),
              ),
            ),
            2.h.verticalSpace,
            CitiesInputWidget(
              addressModel: widget.address,
              form: form,
            ),

            2.h.verticalSpace,
            /// Class District Input
            DistrictInputWidget(
              form: form,
              addressModel: widget.address,
            ),
            2.h.verticalSpace,
            BaseInputWidget(
              formControlName: 'address',
              validationMessages: {
                ValidationMessage.required: (e) => 'Address is required',
              },
              label: "Address",
              labelFontSize: 12.6.sp,
              labelTextColor: Colors.black,
              fontSize: 13.sp,
            ),
          ],
        );
      },
    );
  }
}
