import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gogreen/core/constants/app_icons.dart';
import 'package:gogreen/core/network/remote.wings.dart';
import 'package:gogreen/core/theme/app_colors.dart';

class OnlineImagesWidget extends StatelessWidget {
  final String imageUrl;
  final bool circularImage;
  final bool externalLink;
  final bool hasShadow;
  final Size? size;
  final Widget? child;
  final bool showChild;
  final BoxFit? fit;
  final double? logoWidth;

  const OnlineImagesWidget({
    super.key,
    required this.imageUrl,
    this.externalLink = false,
    this.circularImage = false,
    this.hasShadow = false,
    this.showChild = false,
    this.child,
    this.size,
    this.fit,
    this.logoWidth,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: (externalLink ? '' : AppURL.baseImageURL) + imageUrl,
      placeholder: (context, value) {
        return Container(
          height: size?.height,
          width: size?.width,
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withOpacity(.1),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: showChild
              ? Stack(
                  children: [
                    child!,
                    Center(
                      child: SpinKitPulse(
                        color: AppColors.primaryColor,
                        size: 20.r,
                      ),
                    ),
                  ],
                )
              : Center(
                  child: SpinKitPulse(
                    color: AppColors.primaryColor,
                    size: 20.r,
                  ),
                ),
        );
      },
      imageBuilder: (context, imageProvider) {
        var image = DecorationImage(
          image: imageProvider,
          fit: fit ?? BoxFit.cover,
        );

        return SizedBox(
          height: size?.height,
          width: size?.width,
          child: Stack(
            clipBehavior: Clip.antiAlias,
            children: [
              Container(
                decoration: circularImage
                    ? BoxDecoration(
                        borderRadius: BorderRadius.circular(200),
                        image: image,
                        // boxShadow: hasShadow ? WingsTheme.defaultShadow : [],
                      )
                    : BoxDecoration(
                        image: image,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                height: size?.height,
                width: size?.width,
                child: child,
              ),
            ],
          ),
        );
      },
      errorWidget: (context, url, error) => Container(
        height: size?.height,
        width: size?.width,
        decoration: BoxDecoration(
          color: AppColors.greySwatch.shade50,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: showChild
            ? Stack(
                children: [
                  child!,
                  Center(
                    child: SvgPicture.asset(
                      AppIcons.logo,
                      width:logoWidth?? 48.r,
                    ),
                  ),
                ],
              )
            : Center(
                child: SvgPicture.asset(
                  AppIcons.logo,
                  width: logoWidth?? 48.r,
                ),
              ),
      ),
    );
  }
}
