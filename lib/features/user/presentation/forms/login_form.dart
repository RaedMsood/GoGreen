import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class LoginForm {
  final key = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  final group = FormGroup(
    {
      'email': FormControl<String>(validators: [
        Validators.required,
       ],),
      'password': FormControl<String>(
        validators: [
          Validators.required,
          Validators.minLength(6),
          Validators.maxLength(20),
        ],
        value: '',
      )
    },
  );
}
