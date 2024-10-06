import 'package:flutter/material.dart';
import 'package:gogreen/features/address/data/models/address_model.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AddressStoreFormController {
  final AddressModel address;
  final key = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  final group = FormGroup({
    'address': FormControl<String>(
      validators: [
        Validators.required,
      ],
    ),

    'state_id': FormControl<int>(),
    'state_name': FormControl<String>(
      validators: [
        Validators.required,
      ],
    ),
    'city_id': FormControl<int>(),
    'city_name': FormControl<String>(
      validators: [
        Validators.required,
      ],
    ),
    'district_id': FormControl<int>(),
    'district_name': FormControl<String>(
      validators: [
        Validators.required,
      ],
    ),
  });

  AddressStoreFormController(this.address) {
    fillForm(address);
  }

  void fillForm(AddressModel address) {

    group.patchValue({
      'address': address.address,
      'state_name': address.states!.name.toString(),
      'state_id': address.stateId,
      'city_name': address.city!.nameEn.toString(),
      'city_id': address.cityId,
      'district_name': address.district!.nameEn.toString(),
      'district_id': address.districtId,
    });
  }

}
