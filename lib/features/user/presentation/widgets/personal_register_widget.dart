import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/core/widget/inputs/email_input.dart';
import 'package:gogreen/core/widget/inputs/name_input.dart';
import 'package:gogreen/core/widget/inputs/password_input.dart';
import 'package:gogreen/core/widget/inputs/phone_input.dart';
import 'package:gogreen/features/user/presentation/riverpod/riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';



class RegisterPersonalPage extends ConsumerWidget {
  const RegisterPersonalPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ReactiveFormBuilder(
        form: () => ref.read(registerProvider.notifier).personalForm.group,
        builder: (context, form, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              11.h.verticalSpace,
              NameInputWidget(
                  formControlName: 'name',
                  hintText: 'Name',
                  validation: 'Name',
                  onSubmitted: (_) => form.focus('phone')),
              PhoneInputWidget(
                formControlName: 'phone',
                hintText: '+1 000 000 000',
                onSubmitted: (_) => form.focus('email'),
              ),
              EmailInputWidget(
                formControlName: 'email',
                hintText: 'Enter your email',
                onSubmitted: (_) => form.focus('password'),
              ),
              PasswordInputWidget(
                formControlName: 'password',
                hintText: 'Enter your password',
                onSubmitted: (_) => form.focus('password_confirmation'),
              ),
              const PasswordInputWidget(
                formControlName: 'password_confirmation',
                hintText: 'Confirm your password',
              ),

            ],
          );
        });
  }
}
