import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/core/states/ui.state.dart';
import 'package:gogreen/core/states/view.state.dart';
import 'package:gogreen/core/widget/appbar_widget.dart';
import 'package:gogreen/core/widget/auto_size_text_widget.dart';
import 'package:gogreen/core/widget/buttons/default_button.dart';
import 'package:gogreen/core/helpers/navigateTo.dart';
import 'package:gogreen/features/address/presentation/riverpod/address_riverpod.dart';
import 'package:gogreen/features/user/presentation/pages/verify_page.dart';
import 'package:gogreen/features/user/presentation/widgets/personal_register_widget.dart';
import 'package:gogreen/features/user/presentation/widgets/store_register_widget.dart';
import 'package:gogreen/features/user/presentation/riverpod/riverpod.dart';
import 'package:gogreen/features/user/presentation/widgets/user_is_not_activated_dialog_widget.dart';

class RegisterPage extends ConsumerWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    var controller = ref.watch(registerProvider);

    return Scaffold(
      appBar: AppBarWidget(title: "Sign up"),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.all(14.sp),
        child: UIState(
          state: controller.viewState,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              12.h.verticalSpace,
              AutoSizeTextWidget(
                text: "Create New Account",
                fontSize: 19.5.sp,
                fontWeight: FontWeight.w700,
                maxLines: 1,
              ),
              16.h.verticalSpace,
              AutoSizeTextWidget(
                text: "Personal data",
                fontSize: 12.5.sp,
                fontWeight: FontWeight.w600,
              ),
              RegisterPersonalPage(),
              AutoSizeTextWidget(
                text: "Store data",
                fontSize: 12.5.sp,
              ),
              RegisterStorePage(),
              18.h.verticalSpace,
              DefaultButtonWidget(
                text: "Sign up",
                isLoading: controller.viewState == ViewState.loading,
                onPressed: () async {
                  final isValid = ref.read(registerProvider.notifier).isValid();
                  if (isValid) {
                    if (ref.read(mapProvider.notifier).locationIsEmpty ==
                        false) {
                      // ref.read(registerProvider.notifier).register(context,
                      //     lat: mapController.location.latitude,
                      //     lng: mapController.location.longitude, onSuccess: () {
                      //       navigateTo(context, VerifyPage());
                      //     },
                      //     );
                      ref.read(registerProvider.notifier).sendOTP(context,
                          onSuccess: () {
                            navigateTo(context, VerifyPage());
                      });
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
