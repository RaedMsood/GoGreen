import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'core/theme/theme.dart';
import 'features/cart/data/data_sourse/cart_hive_local.dart';
import 'features/cart/data/data_sourse/company_cart_hive_local.dart';
import 'features/profiles/profile/data/data_sourse/companies_favorite_hive_local.dart';
import 'features/services/notification/firebase_listen_notification.dart';
import 'features/services/notification/notification_service.dart';
import 'launch_page.dart';
import 'locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Hive.initFlutter();
  await Firebase.initializeApp();
  setupLocator();
  await FirebaseListenNotification.init();
  await NotificationService.initializeNotification();



  Hive.registerAdapter(CartModelAdapter());
  Hive.registerAdapter(CartProductModelAdapter());
  Hive.registerAdapter(CompanyModelAdapter());
  Hive.registerAdapter(CompaniesFavoritesModelAdapter());
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: false,
      splitScreenMode: false,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        home: const LaunchPage(),
      ),
    );
  }
}
