import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gogreen/core/constants/app_icons.dart';
import 'package:gogreen/core/theme/app_colors.dart';
import 'package:gogreen/core/widget/auto_size_text_widget.dart';
import 'package:gogreen/core/widget/inputs/name_input.dart';
import 'package:gogreen/core/helpers/navigateTo.dart';
import 'package:gogreen/features/address/presentation/pages/map_page.dart';
import 'package:gogreen/features/address/presentation/riverpod/address_riverpod.dart';
import 'package:gogreen/features/user/presentation/riverpod/riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:reactive_forms/reactive_forms.dart';

class RegisterStorePage extends ConsumerStatefulWidget {
  const RegisterStorePage({super.key});

  @override
  ConsumerState createState() => _RegisterStorePageState();
}

class _RegisterStorePageState extends ConsumerState<RegisterStorePage> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  LatLng location = const LatLng(15.369445, 44.191006);
  StreamSubscription<LatLng>? locationStream;

  @override
  void initState() {
    super.initState();

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
  }

  @override
  void dispose() {
    super.dispose();
    locationStream?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    var mapController = ref.watch(mapProvider);

    return ReactiveFormBuilder(
      form: () => ref.read(registerProvider.notifier).storeForm.group,
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
             NameInputWidget(
              formControlName: 'store_address',
              hintText: 'Store address',
              validation: 'Store address',
              icon: AppIcons.locationHome,
              onSubmitted: (_) => form.focus('commercial_number'),

            ),

            const NameInputWidget(
              formControlName: 'commercial_number',
              hintText: 'Commercial Number',
              validation: 'Commercial Number',
              icon: AppIcons.commercialNumber,
              keyboardType: TextInputType.number,
            ),
            Column(
              children: [
                InkWell(
                  onTap: () {
                    navigateTo(context, MapPage());
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
                                markerId: const MarkerId('2'),
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
            ),
            if (ref.read(mapProvider.notifier).locationIsEmpty ==
                true)
              Padding(
                padding: EdgeInsets.only(top: 8.h),
                child: AutoSizeTextWidget(
                  text:
                  "Store location must be specified",
                  fontSize: 11.sp,
                  colorText: Colors.red,
                ),
              ),
          ],
        );
      },
    );
  }
}
