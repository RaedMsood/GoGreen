import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:gogreen/core/widget/show_notification_desgin_widget.dart';
import 'package:gogreen/features/services/auth/auth.dart';
import 'package:gogreen/firebase_options.dart';

class FirebaseListenNotification {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  static FirebaseListenNotification? _instance;

  factory FirebaseListenNotification() {
    _instance ??= FirebaseListenNotification._();

    return _instance!;
  }

  FirebaseListenNotification._();

  static Future<void> init() async {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform);
    }
    await FirebaseListenNotification()._init();
  }

  Future<void> _init() async {
    await setupInteractedMessage();
  }

  Future<void> setupInteractedMessage() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    String? token = await getToken();

    if (token != null) {
      Auth().updateFcmToken(token);
    }
    // this update refresh token FCM
    FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) async {
      Auth().updateFcmToken(fcmToken);
    });

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      sound: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
    );

    if (initialMessage != null) {}
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      log('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      log('User granted provisional permission');
    } else {
      log('User declined or has not accepted permission');
    }

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );

    myBackGroundMessageHandler();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        ShowNotificationDesignWidget.showNotification(
          title: message.notification!.title!,
          body: message.notification!.body!,
        );
      }
    });
  }

  Future<String?> getToken() async {
    try {
      return await FirebaseMessaging.instance.getToken();
    } catch (ex) {
      return null;
    }
  }

  @pragma("vm:entry-point")
  Future<void> myBackGroundMessageHandler() async {
    RemoteMessage message = const RemoteMessage();
    if (message.notification != null) {
      FirebaseMessaging.onBackgroundMessage(
        (message) {
          return ShowNotificationDesignWidget.showNotification(
            title: message.notification!.title!,
            body: message.notification!.body!,
          );
        },
      );
    }
  }
}
