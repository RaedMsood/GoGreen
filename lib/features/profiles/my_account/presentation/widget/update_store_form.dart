import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class UpdateStoreFormController {
  final key = GlobalKey<FormState>();
  final group = FormGroup(
    {
      'store_name': FormControl<String>(
        validators: [
          Validators.required,
        ],
      ),
      'store_address': FormControl<String>(
        validators: [
          Validators.required,
        ],
      ),
      'commercial_number': FormControl<String>(
        validators: [
          Validators.required,
        ],
      ),

    },
  );
}
