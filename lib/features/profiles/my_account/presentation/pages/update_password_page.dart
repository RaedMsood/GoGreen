import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/core/states/ui.state.dart';
import 'package:gogreen/core/states/view.state.dart';
import 'package:gogreen/core/widget/appbar_widget.dart';
import 'package:gogreen/core/widget/buttons/default_button.dart';
import 'package:gogreen/core/widget/inputs/password_input.dart';
import 'package:gogreen/features/profiles/my_account/presentation/riverpod/my_account_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

class UpdatePasswordPage extends ConsumerWidget {
  const UpdatePasswordPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    var controller = ref.watch(updateMyAccountProvider);

    return Scaffold(
      appBar: AppBarWidget(
        title: "Change Password",
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.all(14.sp),
        child: UIState(
          state: controller.viewState,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ReactiveFormBuilder(
                form: () => ref
                    .read(updateMyAccountProvider.notifier)
                    .changePasswordForm
                    .group,
                builder: (context, form, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PasswordInputWidget(
                        formControlName: 'old_password',
                        hintText: 'Old Password',
                        onSubmitted: (_) => form.focus('new_password'),
                      ),
                      PasswordInputWidget(
                        formControlName: 'new_password',
                        hintText: 'New Password',
                        onSubmitted: (_) => form.focus('password_confirmation'),
                      ),
                      const PasswordInputWidget(
                        formControlName: 'password_confirmation',
                        hintText: 'Confirm Password',
                      ),
                      8.h.verticalSpace,
                      DefaultButtonWidget(
                        text: "Change Password",
                        isLoading: controller.viewState == ViewState.loading,
                        onPressed: () {
                          ref
                              .read(updateMyAccountProvider.notifier)
                              .changePassword(
                                context,
                              );
                        },
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
