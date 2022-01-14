import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:can_i_go_out/main.dart';
import 'package:can_i_go_out/model/profile.dart';

enum UniLinksType { string, uri }

BuildContext globalContext;

ProfileModel globalProfileModel;
bool globalIsOutEnable = false;

String globalLatestLink = 'Unknown';
Uri globalLatestUri;

var globalRestartWidgetKey;
GlobalKey<CanIGoOutHomeState> globalCanIGoOutKey = GlobalKey<CanIGoOutHomeState>();

Size screenSize;

final FlutterLocalNotificationsPlugin globalFlutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

// Streams are created so that app can respond to notification-related events since the plugin is initialised in the `main` function
final BehaviorSubject<ReceivedNotification> globalDidReceiveLocalNotificationSubject =
BehaviorSubject<ReceivedNotification>();

final BehaviorSubject<String> globalSelectNotificationSubject =
BehaviorSubject<String>();

NotificationAppLaunchDetails globalNotificationAppLaunchDetails;

class ReceivedNotification {
  final int id;
  final String title;
  final String body;
  final String payload;

  ReceivedNotification({
    @required this.id,
    @required this.title,
    @required this.body,
    @required this.payload,
  });
}