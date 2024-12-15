import 'dart:convert';

import 'package:bitescan/extentions/loggable.dart';
import 'package:bitescan/utils/utils.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationService with Loggable {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> scheduleSessionConfrirmation({required String sessionId}) async {
    final isMorning = DateTime.now().hour >= 6 && DateTime.now().hour < 12;
    final isEarlyNight = DateTime.now().hour >= 12 && DateTime.now().hour <= 20;
    final isLateNight = DateTime.now().hour < 6 || DateTime.now().hour >= 21;

    if (!isMorning && !isEarlyNight && !isLateNight) {
      logWarning("No Predicted [SessionConfirmation] Notification Time");
      return;
    }
    final fromNow = dateHoursFromNow(isMorning
        ? 12
        : isEarlyNight
            ? 21
            : 10);

    logDebug("scheduled for ${tz.TZDateTime.from(fromNow, tz.local)}");
    return flutterLocalNotificationsPlugin.zonedSchedule(
      2,
      "Confirm your Last shopping Session",
      "You will have a report in the end of the week for all the well choices you made!",
      tz.TZDateTime.from(fromNow, tz.local),
      NotificationDetails(),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  @override
  String get logIdentifier => "[LocalNotificationService]";
}
