import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationsHelper {
  static final _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

//needs an icon
  static final _initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  static final _initializationSettings =
      InitializationSettings(android: _initializationSettingsAndroid);

  static Future<void> init() async {
    await _flutterLocalNotificationsPlugin.initialize(_initializationSettings);
    tz.initializeTimeZones();
  }

  static final _androidNotificationDetails = AndroidNotificationDetails(
    'channel id',
    'channel name',
    'channel description',
    importance: Importance.max,
    priority: Priority.high,
  );

  static final _notificationDetails =
      NotificationDetails(android: _androidNotificationDetails);

// set Notification method
  static Future<void> setNotification(
      DateTime time, TimeOfDay selectedTime, int id,
      {String body, String title}) async {
    tz.TZDateTime zonedTime = tz.TZDateTime.local(time.year, time.month,
        time.day, selectedTime.hour, selectedTime.minute);
    await _flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        title,
        body,

        // tz.TZDateTime(tz.local, dateTime.year, dateTime.month, dateTime.hour,
        //     dateTime.minute),
        tz.TZDateTime.from(zonedTime, (tz.getLocation('Asia/Kathmandu'))),
        _notificationDetails,
        androidAllowWhileIdle: true,
        matchDateTimeComponents: DateTimeComponents.time,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

// cancel Notification methoud
  static Future<void> cancelNotification(int id) async {
    await _flutterLocalNotificationsPlugin.cancel(id);
  }
}
