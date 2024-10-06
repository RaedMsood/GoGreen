import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gogreen/core/constants/app_icons.dart';
import 'package:gogreen/core/theme/app_colors.dart';
import 'package:gogreen/features/services/auth/auth.dart';
import 'core/widget/bottomNavbar/bottom_navigation_bar_widget.dart';
import 'core/helpers/navigateTo.dart';
import 'features/user/presentation/pages/splach_screen_page.dart';

class LaunchPage extends StatefulWidget {
  const LaunchPage({super.key});

  @override
  State<LaunchPage> createState() => _LaunchPageState();
}

class _LaunchPageState extends State<LaunchPage> {
  nav() async {
    await Future.delayed(
      const Duration(
        seconds: 3,
      ),
    ).then((value) async {
      var onBoarding = await Auth().getOnBoarding();

      if (onBoarding != null) {
        navigateAndFinish(context, const BottomNavigationBarWidget());
      } else {
        navigateAndFinish(context, const SplachScreenPage());
      }
    });
  }

  @override
  void initState() {
    nav();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: AppColors.primarySwatch.shade100,
          systemNavigationBarDividerColor: AppColors.primarySwatch.shade100,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
      ),
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(14.sp),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.primaryColor,
              AppColors.primarySwatch.shade600.withOpacity(.99),
              AppColors.primarySwatch.shade400.withOpacity(.8),
              AppColors.primarySwatch.shade100,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            SvgPicture.asset(
              AppIcons.logo,
              height: 85.h,
            ),
            4.h.verticalSpace,
            SvgPicture.asset(
              AppIcons.logoWithText,
              height: 50.h,
            ),
            const Spacer(),
            RichText(
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.4.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'PlusJakartaSans',
                ),
                children: const [
                  TextSpan(
                    text: "Developed by  ",
                  ),
                  TextSpan(
                    text: "D",
                    style: TextStyle(
                      color: Colors.orange,
                    ),
                  ),
                  TextSpan(
                    text: "ev",
                  ),
                  TextSpan(
                    text: "S",
                    style: TextStyle(
                      color: Colors.orange,
                    ),
                  ),
                  TextSpan(
                    text: "tation",
                  ),
                ],
              ),
            ),
            8.h.verticalSpace,
          ],
        ),
      ),
    );
  }
}
