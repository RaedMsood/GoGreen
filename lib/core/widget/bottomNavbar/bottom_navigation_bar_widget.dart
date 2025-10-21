import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/core/constants/app_icons.dart';
import 'package:gogreen/core/helpers/exit_from_the_app.dart';
import 'package:gogreen/core/theme/app_colors.dart';
import 'package:gogreen/core/widget/bottomNavbar/design_for_bottom_navigation_bar_widget.dart';
import 'package:gogreen/core/helpers/navigateTo.dart';
import 'package:gogreen/features/cart/presentation/pages/cart_page.dart';
import 'package:gogreen/features/home/main/presentation/page/home_page.dart';
import 'package:gogreen/features/orders/presentation/pages/my_order_page.dart';
import 'package:gogreen/features/profiles/profile/presentation/pages/profile_page.dart';

var activeIndexProvider = StateProvider<int>((ref) => 0);

class BottomNavigationBarWidget extends ConsumerStatefulWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  ConsumerState createState() => _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState
    extends ConsumerState<BottomNavigationBarWidget> {
  @override
  Widget build(BuildContext context) {
    var activeIndex = ref.watch(activeIndexProvider);
    return Directionality(
      textDirection: Directionality.of(context),
      child: Scaffold(
        body: [
          const ExitFromAppWidget(child:  HomePage()),
          const ExitFromAppWidget(child:  MyOrderPage()),
          const ExitFromAppWidget(child:  ProfilePage()),
        ][activeIndex],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: AppColors.primarySwatch,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18.r),
              topRight: Radius.circular(18.r),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.greySwatch.shade100,
                blurRadius: 10,
                offset: const Offset(0, -1),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  DesignForBottomNavigationBarWidget(
                    icon: AppIcons.bottombarHome,
                    activeIcon: AppIcons.bottombarHomeActive,
                    label: 'Home',
                    active: activeIndex == 0,
                    onTap: () {
                      ref.read(activeIndexProvider.notifier).state = 0;
                    },
                  ),
                  DesignForBottomNavigationBarWidget(
                    icon: AppIcons.bottombarBox,
                    activeIcon: AppIcons.bottombarBoxActive,
                    label: 'Orders',
                    active: activeIndex == 1,
                    onTap: () {
                      ref.read(activeIndexProvider.notifier).state = 1;
                    },
                  ),
                  DesignForBottomNavigationBarWidget(
                    icon: AppIcons.bottombarCartActive,
                    activeIcon: AppIcons.bottombarCartActive,
                    label: 'Cart',
                    active: activeIndex == 3,
                    onTap: () {
                      navigateTo(context, const CartPage());
                    },
                  ),
                  DesignForBottomNavigationBarWidget(
                    icon: AppIcons.bottombarProfile,
                    activeIcon: AppIcons.bottombarProfileActive,
                    label: 'Profile',
                    active: activeIndex == 2,
                    onTap: () {
                      ref.read(activeIndexProvider.notifier).state = 2;
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
