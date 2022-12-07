import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  NotificationService() {
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    initialize();
  }

  getNotificationInstance() {
    return flutterLocalNotificationsPlugin;
  }

  void initialize() {
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('@mipmap/ic_launcher');
    //var initializationSettingsIOS = IOSInitializationSettings(
    //onDidReceiveLocalNotification: onDidReceiveLocalNotification);

    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Kathmandu'));
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  void showNotificationDaily(
      int id, String title, String body, int hour, int minute) async {
    var time = new Time(hour, minute, 0);
    await flutterLocalNotificationsPlugin.showDailyAtTime(
        id, title, body, time, getPlatformChannelSpecfics());
    print('Notification Successfully Scheduled at ${time.toString()}');
    // notifyListeners();
  }

  getPlatformChannelSpecfics() {
    var androidPlatformChannelSpecifics =
        // AndroidNotificationDetails(importance: Importance, priority: Priority);
        AndroidNotificationDetails("channel id", "channel name", "channel desc",
            importance: Importance.max, priority: Priority.high);
    //var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    final platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    return platformChannelSpecifics;
  }

  scheduleAppoinmentNotification(
      {int id, String title, String body, DateTime dateTime}) async {
    var scheduledNotificationDateTime = dateTime;
    await flutterLocalNotificationsPlugin.schedule(id, title, body,
        scheduledNotificationDateTime, getPlatformChannelSpecfics());
  }

  scheduleNotification(
      {int id, String title, String body, DateTime dateTime}) async {
    var scheduledNotificationDateTime = dateTime;

    await flutterLocalNotificationsPlugin.schedule(id, title, body,
        scheduledNotificationDateTime, getPlatformChannelSpecfics());
  }

  periodicNotification(
      {int id, String title, String body, DateTime dateTime}) async {
    await flutterLocalNotificationsPlugin.periodicallyShow(
        0,
        'repeating title',
        'repeating body',
        RepeatInterval.everyMinute,
        getPlatformChannelSpecfics());
  }

  dailyNotification() async {
    var time = Time(10, 0, 0);
    await flutterLocalNotificationsPlugin.showDailyAtTime(
        0,
        'show daily title',
        'Daily notification shown at approximately ',
        time,
        getPlatformChannelSpecfics());
  }

  dailyMedicineNotification(
      {int id, String title, String body, RepeatInterval interval}) async {
    await flutterLocalNotificationsPlugin.periodicallyShow(
        id, title, body, interval, getPlatformChannelSpecfics());
  }

  Future<void> showNotification({
    int id,
    String title,
    String desc,
  }) async {
    await flutterLocalNotificationsPlugin.show(
        id, title, desc, getPlatformChannelSpecfics());
  }

  weeklyNotification() async {
    var time = Time(10, 0, 0);

    await flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
        0,
        'show weekly title',
        'Weekly notification shown on Monday at approximately',
        Day.monday,
        time,
        getPlatformChannelSpecfics());
  }

  Future<void> schedNotification(
      int id, String title, String body, int hour, int minutes) async {
    // final scheduledTime = eventDate.add(Duration(
    //   hours: eventTime.hour,
    //   minutes: eventTime.minute,
    // ));'
//       var  laTime=DateTime.now();
//   laTime = TZDateTime( laTime.2010, 1, 1);
// final detroitTime = TZDateTime.from(laTime,tz.getLocation('Asia/Kathmandu'));
    await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        title,
        body,

        //   tz.TZDateTime.from(other, location)
        // tz.TZDateTime.now().add( Duration(hours:hour,minutes: minutes )),
        tz.TZDateTime.from(DateTime.now(), (tz.getLocation('Asia/Kathmandu'))),
        // tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
        getPlatformChannelSpecfics(),
        androidAllowWhileIdle: true,
        matchDateTimeComponents: DateTimeComponents.time,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  Future<void> reschedule({
    int id,
    String body,
    int hours,
    int minutes,
  }) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'scheduled title',
        'scheduled body',
        tz.TZDateTime.now(tz.local)
            .add(Duration(hours: hours, minutes: minutes)),
        const NotificationDetails(
            android: AndroidNotificationDetails('your channel id',
                'your channel name', 'your channel description')),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  Future<void> registerMessage(
      {int id, String title, String body, int hour, int minutes}) async {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minutes,
    );
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduledDate,
      getPlatformChannelSpecfics(),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  notificationDetails() async {
    var notificationAppLaunchDetails =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    print(notificationAppLaunchDetails.didNotificationLaunchApp);
    print(notificationAppLaunchDetails.payload);
    return notificationAppLaunchDetails;
  }

  Future<void> rrescdule(int hour, int id, String title, String body) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      //_convertTime(hour), // this does not work
      tz.TZDateTime.now(tz.local).add(Duration(seconds: 1)), // this work
      const NotificationDetails(
        android: AndroidNotificationDetails(
            'main_channel', 'Main Channel', "ashwin",
            importance: Importance.max, priority: Priority.max),
        // iOS details
        iOS: IOSNotificationDetails(
          sound: 'default.wav',
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),

      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
    );

    // TZDateTime _convertTime(int hour) {
    //   final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    //   tz.TZDateTime scheduleDate =
    //       tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, 47);
    //
    //   if (scheduledDate.isBefore(now)) {
    //     scheduledDate = scheduledDate.add(const Duration(days: 1));
    //   }
    //   return scheduleDate;
    // }
  }

  Future onSelectNotification(String payload) async {
    await FlutterRingtonePlayer.stop();
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    return Future.value(1);
  }

  void removeReminder(int notificationId) {
    flutterLocalNotificationsPlugin.cancel(notificationId);
  }
}
