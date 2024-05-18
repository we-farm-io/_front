import 'package:awesome_notifications/awesome_notifications.dart';

// class NotificationsServices {
//   void createTaskNotification() {
//     AwesomeNotifications().createNotification(
//         content: NotificationContent(
//             id: 1,
//             channelKey: 'basic_channel',
//             title: 'My first notification',
//             body: 'COMPLETE YOUR TASKS'));
//   }
// }

class NotificationsServices {
  static final NotificationsServices _instance = NotificationsServices._internal();

  factory NotificationsServices() {
    return _instance;
  }

  NotificationsServices._internal();

  void initializeNotifications() {
    AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelGroupKey: "group",
          channelKey: "basic_channel",
          channelName: "Notification",
          channelDescription: "description",
        )
      ],
      channelGroups: [
        NotificationChannelGroup(
          channelGroupKey: "channelGroupKey",
          channelGroupName: "channelGroupName"
        )
      ],
      debug: true
    );

  }

  Future<void> requestNotificationPermissions() async {
    bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) {
      await AwesomeNotifications().requestPermissionToSendNotifications();
    }
  }

  void createTaskNotification(String title, String body) {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1,
        channelKey: 'basic_channel',
        title: title,
        body: body,
      ),
    );
  }

}

