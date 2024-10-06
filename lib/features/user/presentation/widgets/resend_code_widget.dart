import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/core/theme/app_colors.dart';
import 'package:gogreen/core/widget/auto_size_text_widget.dart';
import 'package:gogreen/features/user/presentation/riverpod/riverpod.dart';

class ResendCodeWidget extends StatefulWidget {
  const ResendCodeWidget({
    super.key,
  });

  @override
  State<ResendCodeWidget> createState() => _ResendCodeWidgetState();
}

class _ResendCodeWidgetState extends State<ResendCodeWidget> {
  Timer? _timer;
  int countDown = 60;
  bool canResend = false;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    _timer!.cancel();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (countDown > 0) {
          countDown--;
        } else {
          canResend = true;
          timer.cancel();
        }
      });
    });
  }

  void resend() {
    if (canResend) {
      setState(() {
        countDown = 60;
        canResend = false;
      });
      startTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        var controller = ref.watch(resendOtpProvider);

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AutoSizeTextWidget(
              text: "Resend code in",
              fontSize: 12.5.sp,
              colorText: Colors.white,
              textAlign: TextAlign.center,
            ),
            3.w.horizontalSpace,
            canResend
                ? TextButton(
              onPressed: () {
                ref.read(resendOtpProvider.notifier).resendOtp(context, onSuccess: (){
                  resend();

                });
              },
              child: Text(
                "Resend",
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColors.secondaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
                : AutoSizeTextWidget(
              text:
              "00:${countDown < 10 ? "0${countDown.toString()}" : countDown.toString()}",
              colorText: AppColors.secondaryColor,
              fontSize: 11.5.sp,
            ),
          ],
        );
      },
    );
  }
}
