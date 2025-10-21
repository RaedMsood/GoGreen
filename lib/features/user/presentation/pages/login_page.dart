import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/core/helpers/flash_bar_helper.dart';
import 'package:gogreen/core/states/ui.state.dart';
import 'package:gogreen/core/states/view.state.dart';
import 'package:gogreen/core/theme/app_colors.dart';
import 'package:gogreen/core/widget/auto_size_text_widget.dart';
import 'package:gogreen/core/widget/bottomNavbar/bottom_navigation_bar_widget.dart';
import 'package:gogreen/core/widget/buttons/default_button.dart';
import 'package:gogreen/core/widget/inputs/email_input.dart';
import 'package:gogreen/core/widget/inputs/password_input.dart';
import 'package:gogreen/core/helpers/navigateTo.dart';
import 'package:gogreen/features/orders/presentation/riverpod/order_riverpod.dart';
import 'package:gogreen/features/user/presentation/riverpod/riverpod.dart';
import 'package:gogreen/features/user/presentation/widgets/appbar_user_widget.dart';
import 'package:gogreen/features/user/presentation/widgets/dont_have_an_account_widget.dart';
import 'package:gogreen/features/user/presentation/widgets/general_design_of_user_pages_widget.dart';
import 'package:gogreen/features/user/presentation/widgets/user_is_not_activated_dialog_widget.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'forget_password_page.dart';

class LogInPage extends ConsumerWidget {
  const LogInPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    var controller = ref.watch(loginProvider);

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: appBarUserWidget(title: "Sign in"),
      body: UIState(
        state: controller.viewState,
        child: GeneralDesignOfUserPagesWidget(
          widget: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeTextWidget(
                text: "Welcome",
                fontSize: 13.5.sp,
                colorText: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              7.h.verticalSpace,
              AutoSizeTextWidget(
                text: "Glad to have you back again. Please get up sign in",
                fontSize: 11.sp,
                colorText: Colors.white,
              ),
              16.h.verticalSpace,
              IgnorePointer(
                ignoring: controller.viewState == ViewState.loading,
                child: ReactiveFormBuilder(
                  form: () => ref.read(loginProvider.notifier).loginForm.group,
                  builder: (context, form, _) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        EmailInputWidget(
                          formControlName: 'email',
                          hintText: 'Enter your email',
                          onSubmitted: (_) => form.focus('password'),
                        ),
                        const PasswordInputWidget(
                          formControlName: 'password',
                          hintText: 'Enter your password',
                          margin: EdgeInsets.zero,
                        ),
                        8.h.verticalSpace,
                        InkWell(
                          onTap: () {

                            navigateTo(context, const ForgetPasswordPage());
                          },
                          child: AutoSizeTextWidget(
                            text: "Do you forget your password ?",
                            fontSize: 10.sp,
                            colorText: AppColors.secondaryColor.withOpacity(.9),
                          ),
                        ),
                        21.h.verticalSpace,
                        DefaultButtonWidget(
                          text: "Sign in",
                          gradient: false,
                          background: AppColors.secondaryColor,
                          isLoading: controller.viewState == ViewState.loading,
                          onPressed: () async {
                            form.markAllAsTouched();
                            form.valid;

                            if (form.valid) {
                              ref.read(loginProvider.notifier).login(
                                context,
                                onSuccess: () {
                                  ref
                                      .read(getAllOrdersProvider.notifier)
                                      .getData();
                                  navigateAndFinish(context,
                                      const BottomNavigationBarWidget());
                               showFlashBarSuccess(
                                 context: context,
                                 message: "Login successfully",
                                  );
                                },
                                onUserActivated: (){
                                  showDialog(
                                    useSafeArea: true,
                                    context: context,
                                    builder: (context) {
                                      return const Dialog(
                                        alignment: Alignment.center,
                                        backgroundColor: Colors.transparent,
                                        child: UserIsNotActivatedDialogWidget(),
                                      );
                                    },
                                  );
                                }
                              );
                            }
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),

              /// Class Dont Have An Account
              const DontHaveAnAccountWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
