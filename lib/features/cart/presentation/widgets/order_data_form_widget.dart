import 'package:reactive_forms/reactive_forms.dart';

class OrderDataFormController {

  final group = FormGroup(
    {
      'address_id': FormControl<int>(),
      'address': FormControl<String>(
        validators: [Validators.required],
      ),
      'has_vehicle': FormControl<String>(
        validators: [Validators.required],
      ),
      'vehicle_id': FormControl<int>(),
      'payment_method': FormControl<int>(
        validators: [Validators.required],
      ),
      'note': FormControl<String>(),
      'coupon': FormControl<String>(),
      'coupon_id': FormControl<String>(),
    },

  );

  void reset() {
    group.reset();
    group.control('has_vehicle').updateValue(false);
  }
}

// class HasVehicleValidator extends Validator<dynamic> {
//   final String controlName;
//   final String matchingControlName;
//
//   HasVehicleValidator(this.controlName, this.matchingControlName);
//
//   @override
//   Map<String, dynamic>? validate(AbstractControl<dynamic> control) {
//     final form = control as FormGroup;
//
//     final formControl = form.control(controlName);
//     final matchingFormControl = form.control(matchingControlName);
//
//     if (formControl.value == false && matchingFormControl.value == null) {
//       matchingFormControl.setErrors({'required': true});
//
//       // force messages to show up as soon as possible
//       matchingFormControl.markAsEnabled();
//       if (matchingFormControl.touched) {
//         matchingFormControl.markAsTouched();
//       }
//
//       return {'required': true};
//     } else {
//       if (formControl.value == true) {
//         matchingFormControl.markAsDisabled();
//         matchingFormControl.reset();
//       } else {
//         matchingFormControl.markAsEnabled();
//       }
//       matchingFormControl.removeError('required');
//     }
//
//     return null;
//   }
// }
