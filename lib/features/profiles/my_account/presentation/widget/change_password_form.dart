import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ChangePasswordFormController {
  final key = GlobalKey<FormState>();
  final group = FormGroup(
    {
      'old_password': FormControl<String>(
        validators: [
          Validators.required,
        ],
      ),
      'new_password': FormControl<String>(
        validators: [
          Validators.required,
        ],
      ),
      'password_confirmation': FormControl<String>(
        validators: [
          Validators.required,
        ],
      ),
    },
    validators: [
      Validators.mustMatch('new_password', 'password_confirmation'),
    ],
  );
}
