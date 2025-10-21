import 'package:awesome_notifications/awesome_notifications.dart';

class ShowNotificationDesignWidget{
  static Future<void> showNotification(
      {required final String title,
        required final String body,
        final String? summary,
        final Map<String, String>? payload,
        //final ActionType actionType = ActionType.Default,
        final NotificationLayout notificationLayout = NotificationLayout.Default,
        final NotificationCategory? category,
        final String? bigPicture,
        final bool scheduled = false,
        final int? interval}) async {
    assert(!scheduled || (scheduled && interval != null));
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: -1,
          channelKey: 'high_importance_channel',
          body: body,
          title: title,
          //actionType: actionType,
          notificationLayout: notificationLayout,
          category: category,
          displayOnBackground: true,
          wakeUpScreen: true,
          displayOnForeground: true,
          summary: summary,
          payload: payload,
          bigPicture: bigPicture,

        ),
        schedule: scheduled
            ? NotificationInterval(
          interval: interval!,
          timeZone:
          await AwesomeNotifications().getLocalTimeZoneIdentifier(),
          preciseAlarm: true,
        )
            : null);
  }
}