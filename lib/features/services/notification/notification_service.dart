import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart' as awesome;
import 'package:flutter/foundation.dart';
import 'package:gogreen/core/theme/app_colors.dart';
import 'package:gogreen/features/home/notifications/data/model/model.dart';

// class NotificationService {
//   static String? deviseToken;
//
//   static Future<void> initializeNotification() async {
//     await AwesomeNotifications().initialize(
//         null,
//         [
//           NotificationChannel(
//               channelGroupKey: 'high_importance_channel',
//               channelKey: 'high_importance_channel',
//               channelName: 'chat notification',
//               channelDescription: 'chat notification',
//               importance: NotificationImportance.Max,
//               vibrationPattern: highVibrationPattern,
//               defaultColor: AppColors.primaryColor,
//               ledColor: AppColors.greySwatch.shade600,
//               channelShowBadge: true,
//               onlyAlertOnce: true,
//               playSound: true,
//               criticalAlerts: true),
//         ],
//         channelGroups: [
//           NotificationChannelGroup(
//             channelGroupKey: 'high_importance_channel_group',
//             channelGroupName: 'Group 1',
//           ),
//         ],
//         debug: true);
//
//     await AwesomeNotifications().isNotificationAllowed().then((isAllow) async {
//       if (!isAllow) {
//         return await AwesomeNotifications()
//             .requestPermissionToSendNotifications();
//       }
//     });
//   }
//
//   static Future<void> onNotificationCreatedMethod(
//       ReceivedNotification receivedNotification) async {
//     debugPrint('onNotificationCreatedMethod');
//   }
//
//   static Future<void> onNotificationDisplayedMethod(
//       ReceivedNotification receivedNotification) async {
//     debugPrint('onNotificationDisplayedMethod');
//   }
//
//   static Future<void> onActionReceivedMethod(
//       ReceivedNotification receivedNotification) async {
//     debugPrint('onActionReceivedMethod');
//     final payload = receivedNotification.payload ?? {};
//     if (payload['navigate'] == "true") {}
//   }
//
//   static Future<void> onDismissActionReceivedMethod(
//       ReceivedNotification receivedNotification) async {
//     debugPrint('onDismissActionReceivedMethod');
//   }
// }

class WingsNotification {
  static WingsNotification? _instance;

  factory WingsNotification() {
    _instance ??= WingsNotification._();

    return _instance!;
  }

  WingsNotification._();

  static Future<void> init() async {
    _instance = WingsNotification();

    await WingsNotification()._init();
  }

  Future<void> _init() async {
    awesome.AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
      // 'resource://drawable/ic_launcher',
      'resource://drawable/notification_icon',
      // null,
      [
        awesome.NotificationChannel(
          channelKey: 'high_importance_channel',
          channelName: 'High Importance Notifications',
          channelDescription:
              'This channel is used for important notifications',
          importance: awesome.NotificationImportance.Max,
          playSound: true,
          criticalAlerts: true,
          defaultColor: AppColors.primaryColor,
          ledColor: AppColors.greySwatch.shade600,
          channelShowBadge: true,
          onlyAlertOnce: true,
          groupKey: "1",
          icon: 'resource://drawable/notification_icon',

        ),
      ],

      debug: true,
    );
  }

  static Future<void> clear() async {
    awesome.AwesomeNotifications().dispose();
    awesome.AwesomeNotifications().cancelAll();
  }

  /// Use this method to detect when a new notification or a schedule is created

  bool listening = false;

  Future<void> createNotificationChat(Map<String, dynamic> message) async {
    final data = NotificationModel.fromJson(message);

    await awesome.AwesomeNotifications().createNotification(
      content: awesome.NotificationContent(
        id: createUniqueID(),
        // -1 is replaced by a random number
        channelKey: 'high_importance_channel',

        criticalAlert: true,
        title: data.title,
        body: data.content,
        groupKey: "1",
        displayOnBackground: true,
        displayOnForeground: true,
        wakeUpScreen: true,
        notificationLayout: awesome.NotificationLayout.Default,
        payload: data.toShowNotification(),

      ),
    );

    _onEventReceived(data);
  }

  int createUniqueID({int maxValue = 9999}) {
    Random random = Random();
    return random.nextInt(maxValue);
  }

  void _onEventReceived(NotificationModel model) {}
}
