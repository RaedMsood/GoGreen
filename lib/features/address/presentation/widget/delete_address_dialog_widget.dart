import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/core/helpers/flash_bar_helper.dart';
import 'package:gogreen/core/states/view.state.dart';
import 'package:gogreen/core/theme/app_colors.dart';
import 'package:gogreen/core/widget/auto_size_text_widget.dart';
import 'package:gogreen/core/widget/buttons/default_button.dart';
import 'package:gogreen/features/address/data/models/address_model.dart';
import 'package:gogreen/features/address/presentation/riverpod/address_riverpod.dart';

class DeleteAddressDialogWidget extends ConsumerWidget {
  final AddressModel address;

  const DeleteAddressDialogWidget({super.key, required this.address});

  @override
  Widget build(BuildContext context, ref) {
    var controller = ref.watch(addressStoreProvider(address));

    return Padding(
      padding: EdgeInsets.all(14.sp),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AutoSizeTextWidget(
            text: "Do you want to delete this address?",
            colorText: AppColors.dangerColor.withOpacity(.95),
            fontWeight: FontWeight.w700,
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
          8.h.verticalSpace,
          AutoSizeTextWidget(
            text: "The address will be permanently deleted",
            fontSize: 12.sp,
            colorText: AppColors.greySwatch.shade600,
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
          18.h.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: DefaultButtonWidget(
                  text: 'No',
                  borderRadius: 20.sp,
                  gradient: false,
                  background: AppColors.greySwatch.shade50,
                  textColor: AppColors.greySwatch.shade800,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              14.w.horizontalSpace,
              Expanded(
                child: DefaultButtonWidget(
                  text: 'Yes',
                  borderRadius: 20.sp,
                  gradient: false,
                  background: AppColors.dangerColor.withOpacity(.95),
                  isLoading: controller.viewState == ViewState.loading,
                  onPressed: () {
                    ref
                        .read(addressStoreProvider(address).notifier)
                        .deleteAddress(
                          context,
                          onSuccess: () {
                            ref.refresh(getAllAddressesProvider);
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                            showFlashBarSuccess(
                              message: 'Deleted address successfully',
                              context: context,
                            );

                          },
                        );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
