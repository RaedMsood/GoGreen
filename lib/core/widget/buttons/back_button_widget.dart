import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      icon: CircleAvatar(
        radius: 21.sp,
        backgroundColor: Colors.white12,
        child: const Icon(
          Icons.arrow_back_sharp,
          size: 22,
          color: Colors.white,
        ),
      ),
    );
  }
}
