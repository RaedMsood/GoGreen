import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gogreen/core/constants/app_icons.dart';
import 'package:gogreen/core/theme/app_colors.dart';
import 'package:gogreen/core/widget/inputs/name_input.dart';
import 'package:gogreen/features/address/presentation/pages/map_page.dart';
import 'package:gogreen/features/address/presentation/riverpod/address_riverpod.dart';
import 'package:gogreen/features/profiles/my_account/data/model/my_account_model.dart';
import 'package:gogreen/features/profiles/my_account/presentation/riverpod/my_account_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:reactive_forms/reactive_forms.dart';

class UpdateStoreWidget extends ConsumerStatefulWidget {
  final MyAccountModel myAccountModel;

  const UpdateStoreWidget({super.key, required this.myAccountModel});

  @override
  ConsumerState createState() => _UpdateStoreWidgetState();
}

class _UpdateStoreWidgetState extends ConsumerState<UpdateStoreWidget> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  LatLng location = const LatLng(15.369445, 44.191006);
  StreamSubscription<LatLng>? locationStream;

  @override
  void initState() {
    ref.read(mapProvider.notifier).locationStream.listen((event) {
      setState(() {
        location = event;
        _controller.future.then((value) {
          value.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: event,
                zoom: 15,
              ),
            ),
          );
        });
      });
    });

    Future.delayed(const Duration(milliseconds: 400), () {
      setState(() {
        location = LatLng(
          double.parse(widget.myAccountModel.lat.toString()),
          double.parse(widget.myAccountModel.lng.toString()),
        );
        ref.read(mapProvider.notifier).changeLocation(location);
        ref.read(mapProvider.notifier).confirmLocation();
        _controller.future.then((value) {
          value.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: location,
                zoom: 15,
              ),
            ),
          );
        });
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    locationStream?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(mapProvider);

    return ReactiveFormBuilder(
      form: () => UpdateMyAccountController.storeForm.group,
      builder: (context, form, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            11.h.verticalSpace,
            NameInputWidget(
              formControlName: 'store_name',
              hintText: 'Store Name',
              validation: 'Store Name',
              onSubmitted: (_) => form.focus('store_address'),
              icon: AppIcons.storeName,
            ),
            const NameInputWidget(
              formControlName: 'store_address',
              hintText: 'Store address',
              validation: 'Store address',
              icon: AppIcons.locationHome,
            ),
            const NameInputWidget(
              formControlName: 'commercial_number',
              hintText: 'Commercial Number',
              validation: 'Commercial Number',
              icon: AppIcons.commercialNumber,
            ),
            4.h.verticalSpace,
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  PageTransition(
                    child: MapPage(),
                    type: PageTransitionType.fade,
                    duration: const Duration(milliseconds: 500),
                  ),
                );
                ref.read(mapProvider.notifier).confirmLocation();
              },
              child: IgnorePointer(
                ignoring: true,
                child: Container(
                  height: 160.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: AppColors.darkSwatch.shade200,
                    ),
                    color: AppColors.darkSwatch.shade200,
                  ),
                  child: Stack(
                    children: [
                      GoogleMap(
                        mapType: MapType.normal,
                        initialCameraPosition: CameraPosition(
                          target: location,
                          zoom: 15,
                        ),
                        markers: {
                          Marker(
                            markerId: const MarkerId("2"),
                            position: location,
                            visible: false,
                          ),
                        },
                        zoomControlsEnabled: false,
                        onMapCreated: (GoogleMapController controller) {
                          _controller.complete(controller);
                        },
                      ),
                      Positioned.fill(
                        child: Align(
                            alignment: Alignment.center,
                            child: SvgPicture.asset(AppIcons.mapLocation)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
