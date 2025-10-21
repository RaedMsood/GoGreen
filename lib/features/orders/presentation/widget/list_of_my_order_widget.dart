import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/core/states/view.state.dart';
import 'package:gogreen/core/widget/loading_widget.dart';
import 'package:gogreen/features/orders/presentation/riverpod/order_riverpod.dart';
import 'card_of_my_order_widget.dart';

class ListOfMyOrderWidget extends ConsumerWidget {
   final ScrollController scrollController;
  const ListOfMyOrderWidget( {super.key,required this.scrollController});

  @override
  Widget build(BuildContext context, ref) {
    var controller = ref.watch(getAllOrdersProvider);

    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      controller: scrollController,
      padding: EdgeInsets.all(14.sp),
      itemBuilder: (context, index) {
        if (index == controller.data.data.length) {
          return Padding(
            padding:  EdgeInsets.only(bottom: 6.h),
            child: const CircularProgressIndicatorWidget(),
          );
        }
        return CardOfMyOrderWidget(
          order: controller.data.data[index],
          numberOfItem: controller.data.data.length,
        );
      },
      itemCount: controller.data.data.length +
          (controller.viewState == ViewState.loadingMore ? 1 : 0),
    );
  }
}
