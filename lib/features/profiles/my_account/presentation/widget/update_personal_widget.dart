import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/core/widget/inputs/email_input.dart';
import 'package:gogreen/core/widget/inputs/name_input.dart';
import 'package:gogreen/core/widget/inputs/phone_input.dart';
import 'package:gogreen/features/profiles/my_account/presentation/riverpod/my_account_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

class UpdatePersonalPage extends ConsumerWidget {
  const UpdatePersonalPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ReactiveFormBuilder(
        form: () => UpdateMyAccountController.personalForm.group,
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
              const EmailInputWidget(
                formControlName: 'email',
                hintText: 'Email',
              ),
            ],
          );
        });
  }
}
