import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gogreen/core/constants/app_icons.dart';
import 'package:gogreen/core/helpers/flash_bar_helper.dart';
import 'package:gogreen/core/theme/app_colors.dart';
import 'package:gogreen/core/widget/inputs/base_input.dart';
import 'package:gogreen/core/widget/show_modal_bottom_sheet_widget.dart';
import 'package:gogreen/features/address/data/models/address_model.dart';
import 'package:gogreen/features/address/presentation/widget/list_to_view_all_district_widget.dart';
import 'package:reactive_forms/reactive_forms.dart';

class DistrictInputWidget extends StatelessWidget {
  final AddressModel addressModel;
  final FormGroup form;
  const DistrictInputWidget({super.key, required this.form, required this.addressModel});

  @override
  Widget build(BuildContext context) {
    return  StreamBuilder(
      stream: form.control('city_name').statusChanged,
      builder: (context, snapshot) {
        return BaseInputWidget(
          formControlName: 'district_name',
          keyboardType: TextInputType.none,
          validationMessages: {
            ValidationMessage.required: (e) => 'Province is required',
          },
          cursorHeight: 0,
          label: "Province",
          labelFontSize: 12.6.sp,
          labelTextColor: form.control('city_name').invalid
              ? AppColors.greySwatch.shade500
              : Colors.black,
          fontSize: 13.sp,
          onTap: form.control('city_name').invalid
              ? (_) {
            showFlashBarError(
              message: "Please chose a city",
              context: context,
            );
          }
              : (_) {
            showModalBottomSheetWidget(
              context: context,
              page: ListToViewAllDistrictWidget(
                address: addressModel,
                cityId: form.control('city_id').value,
              ),
            );
          },
          suffix: Padding(
            padding: EdgeInsets.symmetric(vertical: 14.h),
            child: SvgPicture.asset(
              AppIcons.arrowDown,
              color: form.control('city_name').invalid
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

