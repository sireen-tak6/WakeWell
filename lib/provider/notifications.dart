import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz1;
import 'package:timezone/data/latest.dart' as tz;

class noti {
  static Future initialize(FlutterLocalNotificationsPlugin flnb) async {
    var andinit = new AndroidInitializationSettings('mipmap/ic_launcher');
    var initsetting = new InitializationSettings(android: andinit);
    await flnb.initialize(initsetting);
  }

  static Future showBigTextNotification(
      {var id = 0,
      required String title,
      required String body,
      required hour,
      required minute,
      var payload,
      required FlutterLocalNotificationsPlugin fln}) async {
    print('start');
    tz.initializeTimeZones();
    var dattime = DateTime(DateTime.now().year, DateTime.now().month,
        DateTime.now().day, hour, minute, 0);
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        new AndroidNotificationDetails(
      'you_can_name_it_whatever1',
      'channel_name',
      playSound: true,
      importance: Importance.max,
      priority: Priority.high,
    );

    var not = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );
    await fln.zonedSchedule(
        0,
        title,
        body,
        tz1.TZDateTime.from(dattime, tz1.local),
        NotificationDetails(android: androidPlatformChannelSpecifics),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
        matchDateTimeComponents: DateTimeComponents.time);
  }
}
