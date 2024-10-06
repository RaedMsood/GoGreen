import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/core/states/error.state.dart';
import 'package:gogreen/core/states/ui.state.dart';
import 'package:gogreen/features/home/details/presentation/widgets/clear_prev_cart_dialog_widget.dart';
import 'package:gogreen/features/cart/presentation/riverpod/cart.riverpod.dart';
import 'package:gogreen/features/home/details/presentation/riverpod/company_detail_riverpod.dart';
import 'package:gogreen/features/home/main/data/model/company_model.dart';
import 'product_card_widget.dart';
import 'product_shimmer_card_widget.dart';

class ListOfProductCardWidget extends ConsumerWidget {
  final int id;

  const ListOfProductCardWidget({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context, ref) {
    var controller = ref.watch(companyDetailProvider(id));

    ref.watch(cartProvider);
    return UIState(
      state: controller.viewState,
      loadingState: const ProductShimmerCardWidget(),
      errorState: ErrorState.container(
        error: controller.errorModel,
      ),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.all(14.sp),
        itemBuilder: (context, index) {
          return ProductCardWidget(
            product: controller.data.products.data[index],
            companyName: controller.data.name.toString(),
            onAddToCart: () async {
              var company = CompanyModel.fromDetail(
                controller.data,
              );
              var canAdd = await ref.read(cartProvider.notifier).updateCompany(
                    company,
                    detail: true,
                  );
              var value = true;
              if (ref.read(cartProvider).changeCompanyDetail) {
                var a = await ClearPrevCartDialogWidget.show(context, () async {
                  await ref
                      .read(cartProvider.notifier)
                      .clearAllCart()
                      .then((v) async {
                    return await ref
                        .read(cartProvider.notifier)
                        .updateCompany(company);
                  });

                  return true;
                });
                return a;
              } else {
                await ref.read(cartProvider.notifier).updateCompany(company);
                return Future.value(true);
              }
            },
          );
        },
        itemCount: controller.data.products.data.length,
      ),
    );
  }
}
