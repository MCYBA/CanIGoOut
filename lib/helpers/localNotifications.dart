import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:can_i_go_out/globals/main.dart';

Future<void> showIndeterminateProgressNotification(int id) async {
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'indeterminate progress channel',
      'indeterminate progress channel',
      'indeterminate progress channel description',
      channelShowBadge: false,
      importance: Importance.Max,
      priority: Priority.High,
      onlyAlertOnce: true,
      showProgress: true,
      indeterminate: true);
  var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
      androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
  await globalFlutterLocalNotificationsPlugin.show(
      id,
      'indeterminate progress notification title',
      'indeterminate progress notification body',
      platformChannelSpecifics,
      payload: 'item x');
}

Future<void> showTimeoutNotification() async {
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'silent channel id',
      'silent channel name',
      'silent channel description',
      timeoutAfter: 3000,
      styleInformation: DefaultStyleInformation(true, true));
  var iOSPlatformChannelSpecifics =
  IOSNotificationDetails(presentSound: false);
  var platformChannelSpecifics = NotificationDetails(
      androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
  await globalFlutterLocalNotificationsPlugin.show(0, 'timeout notification',
      'Times out after 3 seconds', platformChannelSpecifics);
}

Future<void> cancelNotification(int id) async {
  await globalFlutterLocalNotificationsPlugin.cancel(id);
}

Future<void> showPublicNotification() async {
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your channel id', 'your channel name', 'your channel description',
      importance: Importance.Max,
      priority: Priority.High,
      ticker: 'ticker',
      visibility: NotificationVisibility.Public);
  var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
      androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
  await globalFlutterLocalNotificationsPlugin.show(0, 'Yasağın Başlamasına Son Yarım Saat!',
      'public notification body', platformChannelSpecifics,
      payload: 'item x');
}