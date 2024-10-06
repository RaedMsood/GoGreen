import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gogreen/features/cart/presentation/riverpod/cart.riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'transportation_card_widget.dart';

class ListToViewAllTransportationWidget extends ConsumerStatefulWidget {
  const ListToViewAllTransportationWidget({super.key});

  @override
  ConsumerState<ListToViewAllTransportationWidget> createState() =>
      _ListToViewAllTransportationWidgetState();
}

class _ListToViewAllTransportationWidgetState
    extends ConsumerState<ListToViewAllTransportationWidget> {
  @override
  Widget build(BuildContext context) {
    var controller = ref.watch(getConfirmOrderDataProvider);

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: controller.data.vehicleTypes.length,
      itemBuilder: (context, index) {
        return ReactiveFormBuilder(
          form: () => CartRiverpodController.orderFormController.group,
          builder: (context, form, child) {
            return TransportationCardWidget(
              name: controller.data.vehicleTypes[index].name.toString(),
              value: controller.data.vehicleTypes[index].id.toString(),
              transportationGroupValue:
                  form.control('vehicle_id').value.toString(),
              onPressed: () {
                setState(() {
                  form.control('vehicle_id').value =
                      controller.data.vehicleTypes[index].id;
                  form.control('has_vehicle').value =
                      controller.data.vehicleTypes[index].name;
                });
                Navigator.of(context).pop();
              },
              onChanged: (ind) {
                setState(() {
                  form.control('vehicle_id').value =
                      controller.data.vehicleTypes[index].id;
                  form.control('has_vehicle').value =
                      controller.data.vehicleTypes[index].name;
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
