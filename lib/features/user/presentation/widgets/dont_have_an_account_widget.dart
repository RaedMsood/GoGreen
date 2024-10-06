import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/core/theme/app_colors.dart';
import 'package:gogreen/core/widget/auto_size_text_widget.dart';
import 'package:gogreen/core/helpers/navigateTo.dart';
import 'package:gogreen/features/user/presentation/pages/register_page.dart';

class DontHaveAnAccountWidget extends StatelessWidget {
  const DontHaveAnAccountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AutoSizeTextWidget(
          text: "You don\'t have an account?",
          fontSize: 9.8.sp,
          colorText: Colors.white,
        ),
        TextButton(
          onPressed: () {
            navigateTo(context, const RegisterPage());
          },
          child: AutoSizeTextWidget(
            text: "Sign up",
            fontSize: 10.sp,
            colorText: AppColors.secondaryColor.withOpacity(.9),
          ),
        ),
      ],
    );
  }
}
