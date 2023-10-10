import 'dart:io';

import 'package:flutter/foundation.dart';

import 'package:awesome_notifications/awesome_notifications.dart';

class PushNotificationsService {
  static Future<void> init() async {
    AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: _channelKey,
          channelName: _channelName,
          channelDescription: _channelDescription,
          locked: true,
          importance: NotificationImportance.High,
          channelShowBadge: true,
        ),
      ],
      debug: kDebugMode,
    );

    AwesomeNotifications().setListeners(
      onActionReceivedMethod: onActionReceivedMethod,
      onDismissActionReceivedMethod: onDismissActionReceivedMethod,
    );
  }

  /// Use this method to detect if the user dismissed a notification
  @pragma('vm:entry-point')
  static Future<void> onDismissActionReceivedMethod(ReceivedAction receivedAction) async {
    print('onDismissActionReceivedMethod');
    if (receivedAction.channelKey == _channelKey && Platform.isIOS) {
      final count = await AwesomeNotifications().getGlobalBadgeCounter();
      AwesomeNotifications().setGlobalBadgeCounter(count - 1);
    }
  }

  /// Use this method to detect when the user taps on a notification or action button
  @pragma('vm:entry-point')
  static Future<void> onActionReceivedMethod(ReceivedAction receivedAction) async {
    print('onActionReceivedMethod');
  }

  static Future<void> showNotification() async {
    final notificationId = DateTime.now().millisecondsSinceEpoch % (1 << 31);
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: notificationId,
        channelKey: _channelKey,
        category: NotificationCategory.Event,
        title: 'title',
        body: 'body',
        notificationLayout: NotificationLayout.BigText,
      ),
    );
  }

  static const _channelKey = 'Notifications';
  static const _channelName = 'Уведомления';
  static const _channelDescription = 'Акции, скидки и другие полезные штуки';
}
