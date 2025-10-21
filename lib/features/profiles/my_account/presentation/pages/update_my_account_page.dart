import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/core/constants/app_icons.dart';
import 'package:gogreen/core/helpers/flash_bar_helper.dart';
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
import 'package:gogreen/features/services/auth/auth.dart';
import 'package:gogreen/features/user/presentation/pages/verify_page.dart';
import 'package:gogreen/features/user/presentation/riverpod/riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'update_password_page.dart';

class UpdateMyAccountPage extends ConsumerWidget {
  const UpdateMyAccountPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    var updateMyAccountController = ref.watch(updateMyAccountProvider);
    var getMyAccountController = ref.watch(getMyAccountProvider);
    var mapController = ref.watch(mapProvider);
    var updateEmailController = ref.watch(updateEmailProvider);

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
          : ReactiveFormBuilder(
              form: () => UpdateMyAccountController.personalForm.group,
              builder: (context, form, child) {
                return Padding(
                  padding: EdgeInsets.only(left: 14.w, right: 14.w, top: 8.h),
                  child: DefaultButtonWidget(
                    text: "Save",
                    isLoading: updateMyAccountController.viewState ==
                            ViewState.loading ||
                        updateEmailController.viewState == ViewState.loading,
                    onPressed: () {
                      /// Check if thr entered email is not equal to the saved email.
                      /// I will resend the OTP.

                      if (form.control('email').value != Auth().email) {
                        Auth().setEmail(form.control('email').value);
                        ref.read(updateEmailProvider.notifier).updateEmail(
                            context,
                            oldEmail: Auth().email,
                            newEmail: form.control('email').value,
                            onSuccess: () {
                          navigateTo(
                              context,
                              VerifyPage(
                                updateEmail: true,
                              ));
                        });
                      } else {
                        ref
                            .read(updateMyAccountProvider.notifier)
                            .updateMyAccount(
                              context,
                              lat: mapController.location.latitude,
                              lng: mapController.location.longitude,
                          onSuccess: (){
                            Navigator.of(context).pop();
                            showFlashBarSuccess(
                              message: 'Updated Successfully',
                              context: context,
                            );
                          }
                            );
                      }
                    },
                  ),
                );
              },
            ),
    );
  }
}
