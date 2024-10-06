import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ResetPasswordFormController {
  final key = GlobalKey<FormState>();

  final group = FormGroup(
    {
      'password': FormControl<String>(
        validators: [
          Validators.required,
          Validators.minLength(6),
          Validators.maxLength(20),
        ],
      ),
      'password_confirmation': FormControl<String>(),
    },
    validators: [
      Validators.mustMatch('password', 'password_confirmation'),
    ],
  );
}
