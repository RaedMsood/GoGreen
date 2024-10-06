import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gogreen/features/cart/presentation/riverpod/cart.riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'payment_method_widget.dart';

class ListToViewAllPaymentMethodWidget extends ConsumerStatefulWidget {
  const ListToViewAllPaymentMethodWidget({super.key});

  @override
  ConsumerState<ListToViewAllPaymentMethodWidget> createState() =>
      _ListToViewAllPaymentMethodWidgetState();
}

class _ListToViewAllPaymentMethodWidgetState
    extends ConsumerState<ListToViewAllPaymentMethodWidget> {
  @override
  Widget build(BuildContext context) {
    var controller = ref.watch(getConfirmOrderDataProvider);

    ref.watch(cartProvider);
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemCount: controller.data.paymentMethods.length,
      itemBuilder: (context, index) {
        return ReactiveFormBuilder(
          form: () => CartRiverpodController.orderFormController.group,
          builder: (context, form, child) {
            return PaymentMethodWidget(
              name: controller.data.paymentMethods[index].name.toString(),
              image: controller.data.paymentMethods[index].image.toString(),
              value: controller.data.paymentMethods[index].id.toString(),
              paymentMethodGroupValue:
                  form.control('payment_method').value.toString(),
              subtitle: "Activate now",
              onPressed: () {
                setState(() {
                  form.control('payment_method').value =
                      controller.data.paymentMethods[index].id;
                  ref.refresh(cartProvider.notifier);
                });
              },
              onChanged: (ind) {
                setState(() {
                  form.control('payment_method').value =
                      controller.data.paymentMethods[index].id;
                  ref.refresh(cartProvider.notifier);

                });
              },
            );
          },
        );
      },
    );
  }
}
