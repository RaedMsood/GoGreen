import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/core/constants/app_icons.dart';
import 'package:gogreen/core/theme/app_colors.dart';
import 'package:gogreen/core/widget/appbar_widget.dart';
import 'package:gogreen/core/widget/auto_size_text_widget.dart';
import 'package:gogreen/core/widget/buttons/default_button.dart';
import 'package:gogreen/core/helpers/navigateTo.dart';
import 'package:gogreen/core/widget/show_modal_bottom_sheet_widget.dart';
import 'package:gogreen/features/orders/presentation/pages/my_order_page.dart';
import 'package:gogreen/features/profiles/my_account/presentation/pages/update_my_account_page.dart';
import 'package:gogreen/features/profiles/profile/presentation/widgets/list_tile_profile_widget.dart';
import 'package:gogreen/features/services/auth/auth.dart';
import 'package:gogreen/features/user/presentation/pages/login_page.dart';
import 'address_page.dart';
import 'about_page.dart';
import 'favorites_page.dart';
import 'logout_dialog.dart';
import 'statistic_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: "Profile",
        leading: false,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.all(14.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AutoSizeTextWidget(
              text: "User Data",
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
            ),
            10.h.verticalSpace,
            if (!Auth().loggedIn)
              Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: DefaultButtonWidget(
                  text: "Login",
                  onPressed: () {
                    navigateTo(
                      context,
                      const LogInPage(),
                    );
                  },
                ),
              )
            else
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTileProfileWidget(
                    title: "My Account",
                    icon: AppIcons.myAccount,
                    paddingIconLeft: 3.5.w,
                    onTap: () {
                      navigateTo(context, const UpdateMyAccountPage());
                    },
                  ),
                  ListTileProfileWidget(
                    title: "Address",
                    icon: AppIcons.locationHome,
                    onTap: () {
                      navigateTo(context, const AddressPage());
                    },
                  ),
                  ListTileProfileWidget(
                    title: "My Orders",
                    icon: AppIcons.myOrder,
                    onTap: () {
                      navigateTo(context, const MyOrderPage());
                    },
                  ),
                  ListTileProfileWidget(
                    title: "Stats",
                    icon: AppIcons.stats,
                    iconHeight: 18.h,
                    onTap: () {
                      navigateTo(context, const StatisticsPage());
                    },
                  ),
                  ListTileProfileWidget(
                    title: "Favorite",
                    icon: AppIcons.favorite,
                    iconHeight: 17.h,
                    onTap: () {
                      navigateTo(
                        context,
                        const FavoritesPage(),
                      );
                    },
                  ),
                ],
              ),
            AutoSizeTextWidget(
              text: "More",
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
            ),
            10.h.verticalSpace,
            ListTileProfileWidget(
              title: "Privacy Police",
              icon: AppIcons.privacyPolice,
              iconHeight: 21.h,
              onTap: () {
                navigateTo(
                    context,
                    const AboutPage(
                      title: 'Privacy Policy',
                    ));
              },
            ),
            ListTileProfileWidget(
              title: "About the app",
              icon: AppIcons.aboutTheApp,
              onTap: () {
                navigateTo(
                    context,
                    const AboutPage(
                      title: 'About the app',
                    ));
              },
            ),
            ListTileProfileWidget(
              title: "Application developer",
              icon: AppIcons.applicationDeveloper,
              onTap: () {},
            ),
            Visibility(
              visible: Auth().loggedIn,
              child: ListTileProfileWidget(
                title: "Logout",
                titleColor: AppColors.dangerColor,
                icon: AppIcons.logout,
                iconColor: AppColors.dangerColor,
                onTap: () {
                  showModalBottomSheetWidget(
                    context: context,
                    page: const LogoutDialog(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
