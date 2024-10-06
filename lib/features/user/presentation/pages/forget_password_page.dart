import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/core/states/ui.state.dart';
import 'package:gogreen/core/states/view.state.dart';
import 'package:gogreen/core/theme/app_colors.dart';
import 'package:gogreen/core/widget/auto_size_text_widget.dart';
import 'package:gogreen/core/widget/buttons/default_button.dart';
import 'package:gogreen/core/widget/inputs/email_input.dart';
import 'package:gogreen/core/helpers/navigateTo.dart';
import 'package:gogreen/features/user/presentation/riverpod/riverpod.dart';
import 'package:gogreen/features/user/presentation/widgets/appbar_user_widget.dart';
import 'package:gogreen/features/user/presentation/widgets/general_design_of_user_pages_widget.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'verify_page.dart';

class ForgetPasswordPage extends ConsumerWidget {
  const ForgetPasswordPage({super.key});

  @override
  Widget build(BuildContext context,ref) {
    var controller = ref.watch(forgetPasswordProvider);

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: appBarUserWidget(title: "Forget your password"),
      body: UIState(
        state: controller.viewState,
        child: GeneralDesignOfUserPagesWidget(
          widget: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeTextWidget(
                text:
                "Forgot your password?",
                fontSize: 12.2.sp,
                colorText: Colors.white,
              ),
              20.h.verticalSpace,
              IgnorePointer(
                ignoring: controller.viewState == ViewState.loading,
                child: ReactiveFormBuilder(
                  form: () =>  ref
                      .read(forgetPasswordProvider.notifier)
                      .form
                      .group,
                  builder: (context, form, _) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const EmailInputWidget(
                          formControlName: 'email',
                          hintText: 'Enter your email',
                        ),

                        11.5.h.verticalSpace,
                        DefaultButtonWidget(
                          text: "Verify",
                          gradient: false,
                          background: AppColors.secondaryColor,
                          isLoading: controller.viewState == ViewState.loading,
                          onPressed: () async {
                            form.markAllAsTouched();
                            form.valid;
                            if (form.valid) {
                              ref
                                  .read(forgetPasswordProvider.notifier)
                                  .forgetPassword(
                                context: context,
                                onSuccess: (){
                                  navigateReplacement(
                                      context,
                                      VerifyPage(
                                        verifyCodeWhenYouForgetYourPass: true,
                                      ));
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
            ],
          ),
        ),
      ),
    );
  }
}

