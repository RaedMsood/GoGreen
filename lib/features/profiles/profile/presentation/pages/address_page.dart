import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/core/constants/app_images.dart';
import 'package:gogreen/core/helpers/flash_bar_helper.dart';
import 'package:gogreen/core/network/errors/error.model.wings.dart';
import 'package:gogreen/core/states/error.state.dart';
import 'package:gogreen/core/states/ui.state.dart';
import 'package:gogreen/core/theme/app_colors.dart';
import 'package:gogreen/core/widget/appbar_widget.dart';
import 'package:gogreen/core/widget/buttons/default_button.dart';
import 'package:gogreen/core/helpers/navigateTo.dart';
import 'package:gogreen/features/address/data/models/address_model.dart';
import 'package:gogreen/features/address/presentation/pages/add_a_new_address_page.dart';
import 'package:gogreen/features/address/presentation/riverpod/address_riverpod.dart';
import 'package:gogreen/features/address/presentation/widget/bottom_navigation_bar_button_widget.dart';
import 'package:gogreen/features/profiles/profile/presentation/widgets/address_card_for_my_profile_widget.dart';

class AddressPage extends ConsumerWidget {
  const AddressPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    var controller = ref.watch(getAllAddressesProvider);
    return Scaffold(
      appBar: AppBarWidget(
        title: "Addresses",
      ),
      body: RefreshIndicator(
        color: AppColors.primaryColor,
        onRefresh: () async {
          ref.refresh(getAllAddressesProvider);
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.all(14.sp),
          child: UIState(
            state: controller.viewState,
            loadingState: const ShimmerAddressCardForMyProfileWidget(),
            errorState: Center(
              child: ErrorState.container(
                error: controller.errorModel,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                if (controller.data.isEmpty)
                  ErrorState.container(
                    error: ErrorModel(
                      message: 'Your addresses are empty.',
                      desc: 'Please add address.',
                      icon: AppImages.noData,
                    ),
                  ),
                Column(
                  children: controller.data.map((e) {
                    return AddressCardForMyProfileWidget(address: e);
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: UIState(
        state: controller.viewState,
        loadingState: const SizedBox.shrink(),
        errorState: const SizedBox.shrink(),
        child: BottomNavigationBarDesignWidget(
          child: DefaultButtonWidget(
            text: "Add New Address",
            onPressed: () {
              navigateTo(
                context,
                AddANewAddressPage(
                  address: AddressModel.empty(),
                  locationIsEmpty: true,
                  onSuccess: () async {
                    ref.refresh(getAllAddressesProvider);
                    Navigator.of(context).pop();
                    showFlashBarSuccess(
                      message: 'New address added successfully',
                      context: context,
                    );
                    return true;
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
