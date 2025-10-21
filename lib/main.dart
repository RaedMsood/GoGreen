import 'dart:async';
import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'core/theme/theme.dart';
import 'features/cart/data/data_sourse/cart_hive_local.dart';
import 'features/cart/data/data_sourse/company_cart_hive_local.dart';
import 'features/profiles/profile/data/data_sourse/companies_favorite_hive_local.dart';
import 'features/services/auth/auth.dart';
import 'features/services/notification/firebase_listen_notification.dart';
import 'launch_page.dart';
import 'locator.dart';

Future<void> main() async {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    await Hive.initFlutter();
    await Firebase.initializeApp();
    setupLocator();
    Auth();
    await PushNotificationService.init();

    FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };
    // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };

    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);

    // Pass all uncaught errors to Crashlytics.
    FirebaseCrashlytics.instance.setUserIdentifier("user_id_123");
    FirebaseCrashlytics.instance.setCustomKey("app_version", "1.2.3");

    Hive.registerAdapter(CartModelAdapter());
    Hive.registerAdapter(CartProductModelAdapter());
    Hive.registerAdapter(CompanyModelAdapter());
    Hive.registerAdapter(CompaniesFavoritesModelAdapter());

    runApp(const ProviderScope(child: MyApp()));
  }, (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack));
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
