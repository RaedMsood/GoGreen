import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ForgetPasswordFormController {
  final key = GlobalKey<FormState>();

  final group = FormGroup({
    'email': FormControl<String>(validators: [
      Validators.required,

    ], ),
  });
}
