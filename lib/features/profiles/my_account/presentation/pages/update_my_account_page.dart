import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/core/constants/app_icons.dart';
import 'package:gogreen/core/states/error.state.dart';
import 'package:gogreen/core/states/ui.state.dart';
import 'package:gogreen/core/states/view.state.dart';
import 'package:gogreen/core/widget/appbar_widget.dart';
import 'package:gogreen/core/widget/auto_size_text_widget.dart';
import 'package:gogreen/core/widget/buttons/default_button.dart';
import 'package:gogreen/core/widget/loading_widget.dart';
import 'package:gogreen/core/helpers/navigateTo.dart';
import 'package:gogreen/features/address/presentation/riverpod/address_riverpod.dart';
import 'package:gogreen/features/profiles/my_account/presentation/riverpod/my_account_riverpod.dart';
import 'package:gogreen/features/profiles/my_account/presentation/widget/update_personal_widget.dart';
import 'package:gogreen/features/profiles/my_account/presentation/widget/update_store_widget.dart';
import 'update_password_page.dart';

class UpdateMyAccountPage extends ConsumerWidget {
  const UpdateMyAccountPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    var updateMyAccountController = ref.watch(updateMyAccountProvider);
    var getMyAccountController = ref.watch(getMyAccountProvider);
    var mapController = ref.watch(mapProvider);

    return Scaffold(
      appBar: AppBarWidget(
        title: "My Account",
        action: true,
        actionIcon: AppIcons.key,
        onTapAction: () {
          navigateTo(context, const UpdatePasswordPage());
        },
      ),
      body: UIState(
        state: getMyAccountController.viewState,
        loadingState: const Center(child: CircularProgressIndicatorWidget()),
        errorState: ErrorState.container(
          error: getMyAccountController.errorModel,
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.all(14.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeTextWidget(
                text: "Personal data",
                fontSize: 13.5.sp,
                fontWeight: FontWeight.w600,
              ),
              const UpdatePersonalPage(),
              AutoSizeTextWidget(
                text: "Store data",
                fontSize: 13.5.sp,
              ),
              UpdateStoreWidget(
                myAccountModel: getMyAccountController.data,
              ),
              18.h.verticalSpace,
            ],
          ),
        ),
      ),
      bottomNavigationBar: getMyAccountController.viewState ==
                  ViewState.loading ||
              getMyAccountController.viewState == ViewState.failure
          ? const SizedBox()
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              child: DefaultButtonWidget(
                text: "Save",
                isLoading:
                    updateMyAccountController.viewState == ViewState.loading,
                onPressed: () {
                  ref.read(updateMyAccountProvider.notifier).updateMyAccount(
                        context,
                        lat: mapController.location.latitude,
                        lng: mapController.location.longitude,
                      );
                },
              ),
            ),
    );
  }
}
