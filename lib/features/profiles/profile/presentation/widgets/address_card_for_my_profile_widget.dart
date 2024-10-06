import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gogreen/core/constants/app_icons.dart';
import 'package:gogreen/core/helpers/flash_bar_helper.dart';
import 'package:gogreen/core/theme/app_colors.dart';
import 'package:gogreen/core/widget/auto_size_text_widget.dart';
import 'package:gogreen/core/helpers/navigateTo.dart';
import 'package:gogreen/core/widget/shimmer_widget.dart';
import 'package:gogreen/features/address/data/models/address_model.dart';
import 'package:gogreen/features/address/presentation/pages/add_a_new_address_page.dart';
import 'package:gogreen/features/address/presentation/riverpod/address_riverpod.dart';

class AddressCardForMyProfileWidget extends ConsumerWidget {
  final AddressModel address;

  const AddressCardForMyProfileWidget({super.key, required this.address});

  @override
  Widget build(BuildContext context, ref) {
    return GestureDetector(
      onTap: () {
        navigateTo(
          context,
          AddANewAddressPage(
            address: address,
            onSuccess: () async {
              ref.refresh(getAllAddressesProvider);
              Navigator.of(context).pop();
              showFlashBarSuccess(
                message: 'Updated address successfully',
                context: context,
              );
              return true;
            },
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(8.sp),
        margin: EdgeInsets.only(bottom: 10.h),
        decoration: BoxDecoration(
          color: AppColors.greySwatch.shade50,
          borderRadius: BorderRadius.circular(10.sp),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              AppIcons.address,
              height: 44.h,
            ),
            8.w.horizontalSpace,
            Flexible(
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeTextWidget(
                      text: address.address.toString(),
                      fontSize: 13.6.sp,
                      maxLines: 2,
                      fontWeight: FontWeight.w600,
                    ),
                    3.h.verticalSpace,
                    AutoSizeTextWidget(
                      text:
                          "${address.states!.name.toString()} - ${address.city!.nameEn.toString()} - ${address.district!.nameEn.toString()}",
                      fontSize: 10.6.sp,
                      maxLines: 2,
                      colorText: AppColors.greySwatch.shade600,
                    ),
                  ],
                ),
              ),
            ),
            SvgPicture.asset(
              AppIcons.arrowForward,
              height: 20.h,
            ),
          ],
        ),
      ),
    );
  }
}

class ShimmerAddressCardForMyProfileWidget extends StatelessWidget {
  const ShimmerAddressCardForMyProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 8,
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.all(8.sp),
          margin: EdgeInsets.only(bottom: 10.h),
          decoration: BoxDecoration(
            color: AppColors.greySwatch.shade50,
            borderRadius: BorderRadius.circular(10.sp),
          ),
          child: Row(
            children: [
              ShimmerWidget(
                child: SvgPicture.asset(
                  AppIcons.address,
                  height: 44.h,
                ),
              ),
              8.w.horizontalSpace,
              Flexible(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShimmerPlaceholderWidget(
                        width: 200.w,
                        height: 18.h,
                      ),
                      8.h.verticalSpace,
                      Row(
                        children: [
                          ShimmerPlaceholderWidget(
                            width: 80.w,
                            height: 16.h,
                          ),
                          8.w.horizontalSpace,
                          ShimmerPlaceholderWidget(
                            width: 80.w,
                            height: 16.h,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
