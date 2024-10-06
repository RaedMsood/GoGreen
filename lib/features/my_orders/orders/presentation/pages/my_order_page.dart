import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/core/constants/app_images.dart';
import 'package:gogreen/core/network/errors/error.model.wings.dart';
import 'package:gogreen/core/states/error.state.dart';
import 'package:gogreen/core/states/ui.state.dart';
import 'package:gogreen/core/theme/app_colors.dart';
import 'package:gogreen/core/widget/appbar_widget.dart';
import 'package:gogreen/core/widget/buttons/default_button.dart';
import 'package:gogreen/core/helpers/navigateTo.dart';
import 'package:gogreen/features/my_orders/orders/presentation/riverpod/order_riverpod.dart';
import 'package:gogreen/features/my_orders/orders/presentation/widget/list_of_my_order_widget.dart';
import 'package:gogreen/features/my_orders/orders/presentation/widget/my_order_shimmer_card_widget.dart';
import 'package:gogreen/features/services/auth/auth.dart';
import 'package:gogreen/features/user/presentation/pages/login_page.dart';

class MyOrderPage extends ConsumerStatefulWidget {
  const MyOrderPage({super.key});

  @override
  ConsumerState<MyOrderPage> createState() => _MyOrderPageState();
}

class _MyOrderPageState extends ConsumerState<MyOrderPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      /// call getData from the provider
      ref.read(getAllOrdersProvider.notifier).getData(
            moreData: true,
          );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var controller = ref.watch(getAllOrdersProvider);
    return Scaffold(
      backgroundColor: const Color(0xfffbfbfb),
      appBar: AppBarWidget(
        title: "Order",
        leading: false,
      ),
      body: Consumer(
        builder: (context, ref, child) {
          if (!Auth().loggedIn) {
            return SingleChildScrollView(
              padding: EdgeInsets.all(14.sp),
              child: Column(
                children: [
                  ErrorState.container(
                    verticalPadding: 0.h,
                    error: ErrorModel(
                      icon: AppImages.noAuth,
                      message: 'Login Required',
                      desc: 'Please login to continue',
                      hideRetry: false,
                    ),
                  ),
                  DefaultButtonWidget(
                    text: "Login",
                    width: 160.w,
                    height: 36.h,
                    onPressed: () {
                      navigateTo(
                        context,
                        const LogInPage(),
                      );
                    },
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            color: AppColors.primaryColor,
            onRefresh: () async {
              ref.refresh(getAllOrdersProvider);
            },
            child: UIState(
              state: controller.viewState,
              loadingState: const MyOrderShimmerCardWidget(),
              errorState: SingleChildScrollView(
                child: ErrorState.container(
                  error: controller.errorModel,
                ),
              ),
              child: ListOfMyOrderWidget(
                scrollController: _scrollController,
              ),
            ),
          );
        },
      ),
    );
  }
}
