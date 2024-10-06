import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class RegisterPersonalForm {
  final key = GlobalKey<FormState>();
  final group = FormGroup(
    {
      'name': FormControl<String>(
        validators: [
          Validators.required,
          Validators.minLength(3),
        ],
        value: '',
      ),
      'phone': FormControl<String>(validators: [
        Validators.required,
        Validators.pattern(
            r'^(((\+|00)9677|0?7)[01378]\d{7}|((\+|00)967|0)[1-7]\d{6})$')
      ], value: ''),
      'email': FormControl<String>(
        validators: [
          Validators.required,
        ],
        // value: 'test@gamil.com',
      ),
      'password': FormControl<String>(
        validators: [
          Validators.required,
          Validators.minLength(6),
          Validators.maxLength(20),
        ],
        value: '',
      ),
      'password_confirmation': FormControl<String>(
        value: '',
      ),
    },
    validators: [
      Validators.mustMatch('password', 'password_confirmation'),
    ],
  );
}
