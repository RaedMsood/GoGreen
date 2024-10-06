import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gogreen/core/constants/app_icons.dart';
import 'package:gogreen/core/helpers/flash_bar_helper.dart';
import 'package:gogreen/core/theme/app_colors.dart';
import 'package:gogreen/core/widget/inputs/base_input.dart';
import 'package:gogreen/core/widget/show_modal_bottom_sheet_widget.dart';
import 'package:gogreen/features/address/data/models/address_model.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'list_to_view_all_cities_widget.dart';

class CitiesInputWidget extends StatelessWidget {
  final AddressModel addressModel;
  final FormGroup form;
  const CitiesInputWidget({super.key, required this.form, required this.addressModel});

  @override
  Widget build(BuildContext context) {
    return  StreamBuilder(
      stream: form.control('state_name').statusChanged,
      builder: (context, snapshot) {
        return BaseInputWidget(
          formControlName: 'city_name',
          keyboardType: TextInputType.none,
          validationMessages: {
            ValidationMessage.required: (e) => 'City is required',
          },
          cursorHeight: 0,
          label: "City",
          labelFontSize: 12.6.sp,
          labelTextColor: form.control('state_name').invalid
              ? AppColors.greySwatch.shade500
              : Colors.black,
          fontSize: 13.sp,
          onTap: form.control('state_name').invalid
              ? (_) {
            showFlashBarError(
              message: "Please chose a state",
              context: context,
            );
          }
              : (_) {

            showModalBottomSheetWidget(
              context: context,
              page: ListToViewAllCitiesWidget(
                address: addressModel,
                stateId:form.control('state_id').value ,
              ),
            );
          },
          suffix: Padding(
            padding: EdgeInsets.symmetric(vertical: 14.h),
            child: SvgPicture.asset(
              AppIcons.arrowDown,
              color: form.control('state_name').invalid
                  ? AppColors.greySwatch.shade500
                  : AppColors.primaryColor,
              height: 18.h,
            ),
          ),
        );
      },
    );
  }
}

