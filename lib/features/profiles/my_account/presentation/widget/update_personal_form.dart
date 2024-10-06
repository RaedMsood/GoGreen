import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class UpdatePersonalFormController {
  final key = GlobalKey<FormState>();
  final group = FormGroup(
    {
      'name': FormControl<String>(
        validators: [
          Validators.required,
          Validators.minLength(3),
        ],
      ),
      'phone': FormControl<String>(validators: [
        Validators.required,
        Validators.pattern(
            r'^(((\+|00)9677|0?7)[01378]\d{7}|((\+|00)967|0)[1-7]\d{6})$')
      ],),
      'email': FormControl<String>(
        validators: [
          Validators.required,
        ],
      ),
    },
  );
}
