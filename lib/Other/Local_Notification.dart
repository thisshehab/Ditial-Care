// import 'dart:async';
// import 'dart:io';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class Notifications {
//   final String title;
//   final StreamController<String?> selectNotificationStream =
//       StreamController<String?>.broadcast();
//   final String body;
//   static int number = 0;
//   Future<void> _requestPermissions() async {
//     if (Platform.isIOS || Platform.isMacOS) {
//       await flutterLocalNotificationsPlugin
//           .resolvePlatformSpecificImplementation<
//               IOSFlutterLocalNotificationsPlugin>()
//           ?.requestPermissions(
//             alert: true,
//             badge: true,
//             sound: true,
//           );
//       await flutterLocalNotificationsPlugin
//           .resolvePlatformSpecificImplementation<
//               MacOSFlutterLocalNotificationsPlugin>()
//           ?.requestPermissions(
//             alert: true,
//             badge: true,
//             sound: true,
//           );
//     } else if (Platform.isAndroid) {
//       final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
//           flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
//               AndroidFlutterLocalNotificationsPlugin>();

//       final bool? granted = await androidImplementation?.requestPermission();
//     }
//   }

//   Notifications({required this.title, required this.body});
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//   Future<void> showNotification() async {
//     // await _requestPermissions();
//     final Int64List vibrationPattern = Int64List(3);
//     vibrationPattern[0] = 9000;
//     vibrationPattern[1] = 1000;
//     vibrationPattern[2] = 3000;

//     final AndroidNotificationDetails androidNotificationDetails =
//         AndroidNotificationDetails(
//             'other custom  id+${number}', 'other  channel name+${number}',
//             channelDescription: 'other  channel description',
//             // icon: 'alert',
//             // largeIcon: const DrawableResourceAndroidBitmap('alert.png'),
//             vibrationPattern: vibrationPattern,
//             priority: Priority.max,
//             playSound: true,
//             enableVibration: true,
//             importance: Importance.max,
//             enableLights: false,
//             color: const Color.fromARGB(255, 255, 0, 0),
//             ledColor: const Color.fromARGB(255, 255, 0, 0),
//             ledOnMs: 1000,
//             ledOffMs: 500);
//     number++;
//     final NotificationDetails notificationDetails =
//         NotificationDetails(android: androidNotificationDetails);
//     await initialsettings();
//     await flutterLocalNotificationsPlugin
//         .show(number, title, body, notificationDetails, payload: 'itelm x');
//   }
//   // void _configureSelectNotificationSubject() {
//   //   selectNotificationStream.stream.listen((String? payload) async {
//   //     await Navigator.of(context).push(MaterialPageRoute<void>(
//   //       builder: (BuildContext context) => SecondPage(payload),
//   //     ));
//   //   });
//   // }

//   initialsettings() async {
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('ic_launcher');
//     final DarwinInitializationSettings initializationSettingsDarwin =
//         DarwinInitializationSettings(
//       requestAlertPermission: false,
//       requestBadgePermission: false,
//       requestSoundPermission: false,
//       onDidReceiveLocalNotification:
//           (int id, String? title, String? body, String? payload) async {},
//       // notificationCategories: darwinNotificationCategories,
//     );

//     final InitializationSettings initializationSettings =
//         InitializationSettings(
//       android: initializationSettingsAndroid,
//       iOS: initializationSettingsDarwin,
//       macOS: initializationSettingsDarwin,
//     );

//     await flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//       // onDidReceiveNotificationResponse:
//       //     (NotificationResponse notificationResponse) {
//       //   switch (notificationResponse.notificationResponseType) {
//       //     case NotificationResponseType.selectedNotification:
//       //       selectNotificationStream.add(notificationResponse.payload);
//       //       break;
//       //     case NotificationResponseType.selectedNotificationAction:
//       //     // if (notificationResponse.actionId == navigationActionId) {
//       //     //   selectNotificationStream.add(notificationResponse.payload);
//       //     // }
//       //     // break;
//       //   }
//       // },
//       // onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
//     );
//   }

//   @pragma('vm:entry-point')
//   void notificationTapBackground(NotificationResponse notificationResponse) {
//     // ignore: avoid_print
//     print(
//         'notification(${notificationResponse.id}) action tapped:?????????????????????????????????????????????????????????????????????????????????? '
//         '${notificationResponse.actionId} with'
//         ' payload: ${notificationResponse.payload}');
//     if (notificationResponse.input?.isNotEmpty ?? false) {
//       // ignore: avoid_print
//       print(
//           'notification action tapped with input: ${notificationResponse.input}');
//     }
//   }
// }
