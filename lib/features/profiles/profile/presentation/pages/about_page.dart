import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/core/constants/app_icons.dart';
import 'package:gogreen/core/states/error.state.dart';
import 'package:gogreen/core/states/ui.state.dart';
import 'package:gogreen/core/theme/app_colors.dart';
import 'package:gogreen/core/theme/text_style.dart';
import 'package:gogreen/core/widget/appbar_widget.dart';
import 'package:gogreen/core/widget/loading_widget.dart';
import 'package:gogreen/features/profiles/profile/presentation/riverpod/profile_riverpod.dart';
import 'package:gogreen/features/profiles/profile/presentation/widgets/contact_tile_widget.dart';
import 'package:gogreen/features/profiles/profile/presentation/widgets/social_icon_widget.dart';

class AboutPage extends ConsumerWidget {
  final String title;

  const AboutPage({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context, ref) {
    var controller = ref.watch(appInfoProvider);
    return Scaffold(
      appBar: AppBarWidget(title: title),
      body: UIState(
        state: controller.viewState,
        loadingState: const CircularProgressIndicatorWidget(),
        errorState: Center(
          child: ErrorState.container(
            error: controller.errorModel,
          ),
        ),
        child: SingleChildScrollView(
          padding:
              EdgeInsets.symmetric(horizontal: 18.w),
          child: Column(children: [
            SizedBox(height: 16.h),
            if (title == 'About the app') _aboutPage(controller),
            if (title == 'Privacy Policy')
              _htmlContent(controller.data.privacyPolicy),
          ]),
        ),
      ),
    );
  }

  _htmlContent(String content) {
    return Scrollbar(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Html(
              data: content,
              style: {
                'h1': Style.fromTextStyle(AppTextStyle.medium16),
                'h2': Style.fromTextStyle(AppTextStyle.medium14),
                'h3': Style.fromTextStyle(AppTextStyle.medium14),
                'p': Style.fromTextStyle(
                  AppTextStyle.regular14.copyWith(
                    color: AppColors.secondaryColorFont,
                  ),
                ),
              },
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }

  _aboutPage(controller) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'Version',
              style: AppTextStyle.regular16,
              textDirection: TextDirection.rtl,
            ),
            Text(
              controller.data.applicationVersion,
              style: AppTextStyle.regular16.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.only(bottom: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _htmlContent(controller.data.applicationDescription),
              Container(
                margin: EdgeInsets.only(bottom: 24.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        height: 1.h,
                        color: AppColors.greySwatch,
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      'Contact Us',
                      style: AppTextStyle.regular16,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Expanded(
                      child: Container(
                        height: 1.h,
                        color: AppColors.greySwatch,
                      ),
                    ),
                  ],
                ),
              ),
              ...controller.data.phoneNumbers.map((e) {
                return ContactTileWidget(
                  title: e.phone,
                  icon: AppIcons.phone,
                );
              }),
              ContactTileWidget(
                title: controller.data.email,
                icon: AppIcons.email,
              ),
              SizedBox(height: 14.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SocialIconWidget(
                    icon: AppIcons.twitter,
                    link: controller.data.twitter,
                  ),
                  SocialIconWidget(
                    icon: AppIcons.whatsapp,
                    link: controller.data.whatsapp,
                  ),
                  SocialIconWidget(
                    icon: AppIcons.facebook,
                    link: controller.data.facebook,
                  ),
                  SocialIconWidget(
                    icon: AppIcons.instagram,
                    link: controller.data.instagram,
                  ),
                ],
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ],
    );
  }
}
