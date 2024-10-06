import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gogreen/core/constants/app_icons.dart';
import 'package:gogreen/core/helpers/request_location_permission.dart';
import 'package:gogreen/core/theme/app_colors.dart';
import 'package:gogreen/core/widget/appbar_widget.dart';
import 'package:gogreen/core/widget/buttons/default_button.dart';
import 'package:gogreen/features/address/presentation/riverpod/address_riverpod.dart';
import 'package:gogreen/features/address/presentation/widget/bottom_navigation_bar_button_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends ConsumerWidget {
  // final bool? addOrUpdateAddressStore;
  // final FormGroup? form;

  MapPage({
    super.key,
    // this.addOrUpdateAddressStore = false,
    // this.form,
  });

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  getCurrentLocation({
    required LatLng latLng,
    required WidgetRef ref,
  }) {
    _controller.future.then((value) {
      value.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: latLng,
            zoom: 17,
          ),
        ),
      );
    });
    ref.read(mapProvider.notifier).changeLocation(latLng);
    ref.read(mapProvider.notifier).checkForLocationChanges = true;
  }

  @override
  Widget build(BuildContext context,ref) {
    var controller = ref.watch(mapProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBarWidget(title: "Address on the Map"),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          GoogleMap(
            mapType: MapType.normal,
            zoomControlsEnabled: false,
            initialCameraPosition: CameraPosition(
              target: controller.location,
              zoom: 14.4746,
            ),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            markers: {
              Marker(
                markerId: const MarkerId('1'),
                position: controller.location,
                visible: false,
              ),
            },
            onTap: (latLng) {
              getCurrentLocation(latLng: latLng, ref: ref);
            },
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: SvgPicture.asset(AppIcons.mapLocation),
            ),
          ),
          BottomNavigationBarDesignWidget(
            child: ref.read(mapProvider.notifier).checkForLocationChanges ==
                    false
                ? DefaultButtonWidget(
                    text: "Confirm Address",
                    gradient: false,
                    background:
                        AppColors.primarySwatch.shade600.withOpacity(.5),
                  )
                : DefaultButtonWidget(
                    text: "Confirm Address",
                    onPressed: () async {
                      ref.read(mapProvider.notifier).confirmLocation();
                      ref.read(mapProvider.notifier).locationIsEmpty = false;
                      // if (addOrUpdateAddressStore == true) {
                      //    _getLocationDetails(controller.location);
                      // }
                      Navigator.pop(context);
                    },
                  ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 65.h),
        child: FloatingActionButton(
          backgroundColor: AppColors.primaryColor,
          elevation: 0,
          child: const Icon(
            Icons.my_location,
            color: Colors.white,
            size: 26,
          ),
          onPressed: () async {
            Position position =
                await requestLocationPermissionAndGetCurrentLocation();
            getCurrentLocation(
              latLng: LatLng(position.latitude, position.longitude),
              ref: ref,
            );
          },
        ),
      ),
    );
  }

  // Future<void> _getLocationDetails(LatLng location) async {
  //   try {
  //     List<Placemark> placemarks =
  //         await placemarkFromCoordinates(location.latitude, location.longitude);
  //     if (placemarks.isNotEmpty) {
  //       Placemark placemark = placemarks[0];
  //
  //         form!.patchValue({
  //           'state_name': placemark.country.toString(),
  //           'state_id': 0,
  //           'city_name': placemark.locality ?? '',
  //           'city_id': 0,
  //           'district_name': placemark.subAdministrativeArea ?? '',
  //           'district_id': 0,
  //         });
  //
  //     }
  //   } catch (e) {
  //     throw '$e';
  //   }
  // }
}
