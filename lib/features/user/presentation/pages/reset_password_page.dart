import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/core/helpers/flash_bar_helper.dart';
import 'package:gogreen/core/states/ui.state.dart';
import 'package:gogreen/core/states/view.state.dart';
import 'package:gogreen/core/theme/app_colors.dart';
import 'package:gogreen/core/widget/auto_size_text_widget.dart';
import 'package:gogreen/core/widget/buttons/default_button.dart';
import 'package:gogreen/core/widget/inputs/password_input.dart';
import 'package:gogreen/features/user/presentation/pages/login_page.dart';
import 'package:gogreen/features/user/presentation/riverpod/riverpod.dart';
import 'package:gogreen/features/user/presentation/widgets/appbar_user_widget.dart';
import 'package:gogreen/features/user/presentation/widgets/general_design_of_user_pages_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ResetPasswordPage extends ConsumerWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    var controller = ref.watch(resetPasswordProvider);

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: appBarUserWidget(title: "New Password"),
      body: UIState(
        state: controller.viewState,
        child: GeneralDesignOfUserPagesWidget(
          widget: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeTextWidget(
                text: "Create a new password",
                fontSize: 13.5.sp,
                colorText: Colors.white,
                fontWeight: FontWeight.w700,
                maxLines: 1,
              ),
              8.h.verticalSpace,
              AutoSizeTextWidget(
                text: "Please add a good password to protect your data",
                fontSize: 11.sp,
                colorText: Colors.white,
                maxLines: 1,
              ),
              18.h.verticalSpace,
              IgnorePointer(
                ignoring: controller.viewState == ViewState.loading,
                child: ReactiveFormBuilder(
                  form: () =>
                      ref.read(resetPasswordProvider.notifier).form.group,
                  builder: (context, form, _) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        PasswordInputWidget(
                          formControlName: 'password',
                          hintText: 'Enter your password',
                          onSubmitted: (_) =>
                              form.focus('password_confirmation'),
                        ),
                        const PasswordInputWidget(
                          formControlName: 'password_confirmation',
                          hintText: 'Confirm your password',
                        ),
                        14.h.verticalSpace,
                        DefaultButtonWidget(
                          text: "Next",
                          gradient: false,
                          background: AppColors.secondaryColor,
                          isLoading: controller.viewState == ViewState.loading,
                          onPressed: () async {
                            form.markAllAsTouched();
                            form.valid;
                            if (form.valid) {
                              ref
                                  .read(resetPasswordProvider.notifier)
                                  .resetPassword(context, onSuccess: () {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    PageTransition(
                                      child: const LogInPage(),
                                      type: PageTransitionType.fade,
                                      duration:
                                          const Duration(milliseconds: 500),
                                    ), (route) {
                                  return route.isFirst;
                                });
                                showFlashBarSuccess(
                                  message: "Password changed successfully",
                                  context: context,
                                );
                              });
                            }
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
