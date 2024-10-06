import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/core/constants/app_icons.dart';
import 'package:gogreen/core/states/error.state.dart';
import 'package:gogreen/core/states/view.state.dart';
import 'package:gogreen/core/widget/appbar_widget.dart';
import 'package:gogreen/core/widget/auto_size_text_widget.dart';
import 'package:gogreen/core/widget/buttons/default_button.dart';
import 'package:gogreen/core/widget/loading_widget.dart';
import 'package:gogreen/core/widget/show_modal_bottom_sheet_widget.dart';
import 'package:gogreen/features/address/data/models/address_model.dart';
import 'package:gogreen/features/address/presentation/riverpod/address_riverpod.dart';
import 'package:gogreen/features/address/presentation/widget/add_a_new_address_widget.dart';
import 'package:gogreen/features/address/presentation/widget/bottom_navigation_bar_button_widget.dart';
import 'package:gogreen/features/address/presentation/widget/delete_address_dialog_widget.dart';
import 'package:gogreen/features/address/presentation/widget/view_location_on_map_widget.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AddANewAddressPage extends ConsumerWidget {
  final AddressModel address;
  final Future<bool> Function() onSuccess;
  final bool? locationIsEmpty;

  const AddANewAddressPage(
      {super.key,
      required this.address,
      required this.onSuccess,
      this.locationIsEmpty = false});

  @override
  Widget build(BuildContext context, ref) {
    var controller = ref.watch(addressStoreProvider(address));
    var states = ref.watch(statesProvider);
    var cities = ref.watch(citiesProvider);
    var districts = ref.watch(districtsProvider);
    var mapController = ref.watch(mapProvider);

    return Scaffold(
      appBar: AppBarWidget(
        title: "Address",
        action: address.id != 0 ? true : false,
        actionIcon: AppIcons.trash,
        onTapAction: () {
          showModalBottomSheetWidget(
            context: context,
            page: DeleteAddressDialogWidget(
              address: address,
            ),
          );
        },
      ),
      body: Consumer(
        builder: (context, ref, child) {
          if (states.viewState == ViewState.loading ||
              districts.viewState == ViewState.loading ||
              cities.viewState == ViewState.loading) {
            return const CircularProgressIndicatorWidget();
          }
          if (states.viewState == ViewState.failure ||
              districts.viewState == ViewState.failure ||
              cities.viewState == ViewState.failure) {
            return Center(
              child: ErrorState.container(
                error: states.errorModel,
              ),
            );
          }
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.all(14.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeTextWidget(
                  text: address.id != 0
                      ? "Update Addresses"
                      : "Add New Addresses",
                  fontSize: 13.4.sp,
                ),
                14.h.verticalSpace,

                /// Class add city and dist and address
                AddANewAddressWidget(
                  address: address,
                ),
                8.h.verticalSpace,

                /// Class view location on map
                ViewLocationOnMapWidget(
                  address: address,
                ),

                locationIsEmpty == true
                    ? Column(
                  children: [
                    if (ref.read(mapProvider.notifier).locationIsEmpty ==
                        true)
                      Padding(
                        padding: EdgeInsets.only(top: 10.h),
                        child: Center(
                          child: AutoSizeTextWidget(
                            text:
                            "Please specify store location on the map",
                            fontSize: 10.8.sp,
                            colorText: Colors.red,
                          ),
                        ),
                      ),
                  ],
                )
                    : const SizedBox(),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: states.viewState == ViewState.success &&
              cities.viewState == ViewState.success &&
              districts.viewState == ViewState.success
          ? BottomNavigationBarDesignWidget(
              child: DefaultButtonWidget(
                text: "Save",
                isLoading: controller.viewState == ViewState.loading,
                onPressed: () {
                  ref
                      .read(addressStoreProvider(address).notifier)
                      .addOrUpdateAddress(
                        context: context,
                        lat: mapController.location.latitude,
                        lng: mapController.location.longitude,
                        onSuccess: onSuccess,
                      );
                },
              ),
            )
          : null,
    );
  }
}
