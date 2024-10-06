import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewDialogWidget {
  static show(BuildContext context, String image) {
    if (image.isEmpty) return;
    Future.delayed(Duration.zero, () {
      showDialog(
          context: context,
          builder: (context) {
            return PhotoView(
              imageProvider: CachedNetworkImageProvider(image),
              minScale: PhotoViewComputedScale.contained * 0.8,
              maxScale: PhotoViewComputedScale.covered * 1.8,
              initialScale: PhotoViewComputedScale.contained * 1.1,
              basePosition: Alignment.center,
              backgroundDecoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              loadingBuilder: (context, event) => Center(
                child: SizedBox(
                  width: 20.w,
                  height: 20.h,
                  child: CircularProgressIndicator(
                    value: event == null
                        ? 0
                        : event.cumulativeBytesLoaded /
                            event.expectedTotalBytes!,
                  ),
                ),
              ),
            );
          });
    });
  }
}
