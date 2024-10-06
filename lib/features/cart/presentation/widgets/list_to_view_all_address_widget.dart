import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gogreen/features/cart/presentation/riverpod/cart.riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'address_card_widget.dart';

class ListToViewAllAddressWidget extends ConsumerStatefulWidget {
  const ListToViewAllAddressWidget({super.key});

  @override
  ConsumerState<ListToViewAllAddressWidget> createState() =>
      _ListToViewAllAddressWidgetState();
}

class _ListToViewAllAddressWidgetState
    extends ConsumerState<ListToViewAllAddressWidget> {
  @override
  Widget build(BuildContext context) {
    var controller = ref.watch(getConfirmOrderDataProvider);

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: controller.data.userAddresses.length,
      itemBuilder: (context, index) {
        return ReactiveFormBuilder(
          form: () => CartRiverpodController.orderFormController.group,
          builder: (context, form, child) {
            return AddressCardWidget(
              address: controller.data.userAddresses[index].address.toString(),
              addressGroupValue: form.control('address_id').value.toString(),
              value: controller.data.userAddresses[index].id.toString(),
              state: controller.data.userAddresses[index].states!.name.toString(),
              city: controller.data.userAddresses[index].city!.nameEn.toString(),
              district: controller.data.userAddresses[index].district!.nameEn.toString(),
              onPressed: () {
                setState(() {
                  form.control('address_id').value =
                      controller.data.userAddresses[index].id;
                  form.control('address').value =
                      controller.data.userAddresses[index].address;
                });
                Navigator.of(context).pop();
              },
              onChanged: (ind) {
                setState(() {
                  form.control('address_id').value =
                      controller.data.userAddresses[index].id;
                  form.control('address').value =
                      controller.data.userAddresses[index].address;
                });
                Navigator.of(context).pop();
              },
            );
          },
        );
      },
    );
  }
}
