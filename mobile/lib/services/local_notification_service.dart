import 'dart:io';

import 'package:bitescan/extentions/loggable.dart';
import 'package:bitescan/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:timezone/timezone.dart' as tz;

abstract class NotificationEvent<T> extends Equatable {
  int get id;
  T handlePayload(String? payload);

  @override
  List<Object?> get props => [id];
}

class LocalNotificationService with Loggable {
  final instance = FlutterLocalNotificationsPlugin();

  final List<NotificationEvent> notificationEvents;

  LocalNotificationService({this.notificationEvents = const []});

  Future<void> init() async {
    if (!Platform.isAndroid) return;

    final initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      linux:
          LinuxInitializationSettings(defaultActionName: 'Open notification'),
    );

    await instance.initialize(initializationSettings);

    await instance.getNotificationAppLaunchDetails().then((v) {
      if (v == null ||
          !v.didNotificationLaunchApp ||
          v.notificationResponse == null) return;

      try {
        final event = notificationEvents
            .firstWhere((test) => test.id == v.notificationResponse!.id);

        event.handlePayload(v.notificationResponse!.payload);
      } catch (e) {}
    });
  }

  Future<void> requestPermission() async {
    if (!Platform.isAndroid) return;
    await instance
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  final AndroidNotificationDetails _confirmationDetails =
      AndroidNotificationDetails(
    'confirmation',
    'Shopping Confirmation',
    importance: Importance.max,
    priority: Priority.high,
    ticker: 'ticker',
  );

  Future<void> scheduleSessionConfrirmation({required String sessionId}) async {
    if (!Platform.isAndroid) return;

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

    final t = tz.TZDateTime.now(tz.local).add(Duration(minutes: 2));
    return instance.zonedSchedule(
      2,
      "Confirm your Last shopping Session",
      "You will have a report in the end of the week for all the well choices you made!",
      t,
      payload: sessionId,
      NotificationDetails(android: _confirmationDetails),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.wallClockTime,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
    );
  }

  @override
  String get logIdentifier => "[LocalNotificationService]";
}
