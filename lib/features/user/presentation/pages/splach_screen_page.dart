import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/core/constants/app_images.dart';
import 'package:gogreen/core/theme/app_colors.dart';
import 'package:gogreen/core/widget/auto_size_text_widget.dart';
import 'package:gogreen/core/widget/bottomNavbar/bottom_navigation_bar_widget.dart';
import 'package:gogreen/core/helpers/navigateTo.dart';
import 'package:gogreen/features/services/auth/auth.dart';
import 'package:gogreen/features/user/presentation/widgets/splach_screen_widget.dart';

class SplachScreenPage extends StatefulWidget {
  const SplachScreenPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SplachScreenPage> createState() => _SplachScreenPageState();
}

class _SplachScreenPageState extends State<SplachScreenPage> {
  int currentIndex = 0;
  var controller = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
      image: "",
      title: "Discover Local Flavors",
      description:
          "Explore a variety of homemade dishes, fresh produce, and delightful snacks. Our community members are ready to share their culinary creations with you!",
    ),
    BoardingModel(
      image: "",
      title: "Share and Earn Rewards",
      description:
          "Every shared meal brings you closer to exclusive rewards. Contribute to a sustainable food-sharing ecosystem and earn points to unlock exciting benefits",
    ),
    BoardingModel(
      image: "",
      title: "Easy and Safe Transactions",
      description:
          "Experience hassle-free transactions and a secure environment for food sharing. Connect with trustworthy neighbors, exchange meals, and enjoy the convenience of our platform",
    ),
  ];

  @override
  void initState() {
    controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        actions: [
          TextButton(
            child: AutoSizeTextWidget(
              text: "Skip",
              colorText: Colors.white,
              fontSize: 13.sp,
            ),
            onPressed: () {
              Auth().cacheOnBoarding(true).then((value) {
                navigateAndFinish(
                  context,
                  const BottomNavigationBarWidget(),
                );
              });
            },
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.primaryColor,
              AppColors.primarySwatch.shade600.withOpacity(.99),
              AppColors.primarySwatch.shade400.withOpacity(.8),
              AppColors.primarySwatch.shade100.withOpacity(.99),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 80.h),
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          AppImages.topPattern,
                        ),
                        alignment: Alignment.topLeft,
                      ),
                    ),
                    child: Image.asset(
                      AppImages.splashScreen,
                      height: 300.h,
                      width: double.infinity,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 210.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(18.r),
                  topLeft: Radius.circular(18.r),
                ),
              ),
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: controller,
                itemCount: boarding.length,
                onPageChanged: (int index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return SplachScreenWidget(
                    title: boarding[index].title.toString(),
                    description: boarding[index].description.toString(),
                    controller: controller,
                    currentIndex: currentIndex,
                    boardingLength: boarding.length,
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

class BoardingModel {
  final String image;
  final String title;
  final String description;

  BoardingModel({
    required this.image,
    required this.title,
    required this.description,
  });
}
