import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/foundation.dart';
import 'package:gogreen/core/theme/app_colors.dart';

class NotificationService {
  static String? deviseToken;

  static Future<void> initializeNotification() async {
    await AwesomeNotifications().initialize(
        null,
        [
          NotificationChannel(
              channelGroupKey: 'high_importance_channel',
              channelKey: 'high_importance_channel',
              channelName: 'chat notification',
              channelDescription: 'chat notification',
              importance: NotificationImportance.Max,
              vibrationPattern: highVibrationPattern,
              defaultColor: AppColors.primaryColor,
              ledColor: AppColors.greySwatch.shade600,
              channelShowBadge: true,
              onlyAlertOnce: true,
              playSound: true,
              criticalAlerts: true),
        ],
        channelGroups: [
          NotificationChannelGroup(
            channelGroupKey: 'high_importance_channel_group',
            channelGroupName: 'Group 1',
          ),
        ],
        debug: true);

    await AwesomeNotifications().isNotificationAllowed().then((isAllow) async {
      if (!isAllow) {
        return await AwesomeNotifications()
            .requestPermissionToSendNotifications();
      }
    });
  }

  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    debugPrint('onNotificationCreatedMethod');
  }

  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    debugPrint('onNotificationDisplayedMethod');
  }

  static Future<void> onActionReceivedMethod(
      ReceivedNotification receivedNotification) async {
    debugPrint('onActionReceivedMethod');
    final payload = receivedNotification.payload ?? {};
    if (payload['navigate'] == "true") {}
  }

  static Future<void> onDismissActionReceivedMethod(
      ReceivedNotification receivedNotification) async {
    debugPrint('onDismissActionReceivedMethod');
  }
}
