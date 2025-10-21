import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/core/helpers/flash_bar_helper.dart';
import 'package:gogreen/core/states/view.state.dart';
import 'package:gogreen/core/theme/app_colors.dart';
import 'package:gogreen/core/widget/auto_size_text_widget.dart';
import 'package:gogreen/core/widget/bottomNavbar/bottom_navigation_bar_widget.dart';
import 'package:gogreen/core/widget/buttons/default_button.dart';
import 'package:gogreen/core/helpers/navigateTo.dart';
import 'package:gogreen/features/address/presentation/riverpod/address_riverpod.dart';
import 'package:gogreen/features/profiles/my_account/presentation/riverpod/my_account_riverpod.dart';
import 'package:gogreen/features/services/auth/auth.dart';
import 'package:gogreen/features/user/presentation/riverpod/riverpod.dart';
import 'package:gogreen/features/user/presentation/widgets/appbar_user_widget.dart';
import 'package:gogreen/features/user/presentation/widgets/general_design_of_user_pages_widget.dart';
import 'package:gogreen/features/user/presentation/widgets/resend_code_widget.dart';
import 'package:gogreen/features/user/presentation/widgets/verify_pinput_widget.dart';
import '../../../orders/presentation/riverpod/order_riverpod.dart';
import 'reset_password_page.dart';

class VerifyPage extends ConsumerWidget {
  final bool? verifyCodeWhenYouForgetYourPass;
  final bool? updateEmail;

  VerifyPage({
    super.key,
    this.verifyCodeWhenYouForgetYourPass = false,
    this.updateEmail = false,
  });

  final formKey = GlobalKey<FormState>();

  TextEditingController verifyController = TextEditingController();

  @override
  Widget build(BuildContext context, ref) {
    var controller = ref.watch(checkOtpProvider);
    var registerController = ref.watch(registerProvider);
    var mapController = ref.watch(mapProvider);

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: appBarUserWidget(title: "Verify"),
      body: Form(
        key: formKey,
        child: GeneralDesignOfUserPagesWidget(
          widget: Column(
            children: [
              AutoSizeTextWidget(
                text:
                    "Code has been send to  ${Auth().tempEmail.toString().substring(0, 3)}******.com",
                fontSize: 13.sp,
                colorText: Colors.white,
                textAlign: TextAlign.center,
              ),
              38.h.verticalSpace,

              /// Class Pinput
              VerifyPinputWidget(
                verifyController: verifyController,
              ),
              40.h.verticalSpace,

              /// Class Resend Code Widget
               const ResendCodeWidget(),
              28.h.verticalSpace,
              DefaultButtonWidget(
                text: "Verify",
                height: 45.h,
                borderRadius: 12.sp,
                gradient: false,
                isLoading: controller.viewState == ViewState.loading ||
                    registerController.viewState == ViewState.loading,
                background: AppColors.secondaryColor,
                onPressed: () async {
                  final isValid = formKey.currentState!.validate();

                  if (isValid) {
                    ref.read(checkOtpProvider.notifier).checkOtp(
                          context,
                          otp: verifyController.text,
                          onSuccess: updateEmail == true
                              ? () {
                            ref
                                .read(updateMyAccountProvider.notifier)
                                .updateMyAccount(
                              context,
                              lat: mapController.location.latitude,
                              lng: mapController.location.longitude,
                                onSuccess: (){
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                  showFlashBarSuccess(
                                    message: 'Updated Successfully',
                                    context: context,
                                  );
                                }
                            );
                          }
                              : verifyCodeWhenYouForgetYourPass == true
                                  ? () {
                                      navigateReplacement(
                                          context, const ResetPasswordPage());
                                    }
                                  : () {
                                      ref
                                          .read(registerProvider.notifier)
                                          .register(
                                        context,
                                        lat: mapController.location.latitude,
                                        lng: mapController.location.longitude,
                                        onSuccess: () {
                                          navigateAndFinish(context,
                                              const BottomNavigationBarWidget());
                                          ref
                                              .read(
                                                  getAllOrdersProvider.notifier)
                                              .getData();
                                          showFlashBarSuccess(
                                            message:
                                                "Account created successfully",
                                            context: context,
                                          );
                                        },
                                      );
                                    },
                        );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// Navigator.pushAndRemoveUntil(
// context,
// PageTransition(
// child: const LogInPage(),
// type: PageTransitionType.fade,
// duration:
// const Duration(milliseconds: 500),
// ), (route) {
// return route.isFirst;
// });
// FlashBarHelper.showFlashBarSuccess(
// message: "Account activated successfully",
// context: context,
// );
