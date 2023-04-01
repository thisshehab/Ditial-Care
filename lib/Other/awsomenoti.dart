import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:patient_observing/Screens/Add_Patient/Add_Patient_Veiw.dart';

import '../main.dart';

class CustomNotification {
  String title;
  String body;
  int id;
  Color color;
  Map<String, String> payload;
  CustomNotification(
      {required this.title,
      required this.payload,
      required this.body,
      required this.color,
      required this.id});
  sendnoti() async {
    AwesomeNotifications().isNotificationAllowed().then((isA110wed) async {
      if (!isA110wed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      } else {
        await AwesomeNotifications().createNotification(
            content: NotificationContent(
          badge: 1,
          channelKey: 'basic channel',
          color: color,
          locked: true,
          title: title,
          payload: payload,
          body: body,
          id: id,
        ));
      }
    });
  }
}

class NotificationController {
  bool makealarm = false;
  static int number = 1;
  static const int secondstomakealarm = 20;

  /// Use this method to detect when a new notification or a schedule is created
  @pragma("vm:entry-point")
  Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    makealarm = true;
    var docid = receivedNotification.payload!["data"];
    // Your code goes here
    Future.delayed(
      const Duration(seconds: secondstomakealarm),
      () async {
        if (makealarm) {
          await FirebaseDatabase.instance
              .ref()
              .child("/dashboard")
              .child(docid!)
              .update({"$number": docid});
        }
      },
    );
  }

  /// Use this method to detect every time that a new notification is displayed
  @pragma("vm:entry-point")
  Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    // Your code goes here
  }

  /// Use this method to detect if the user dismissed a notification
  @pragma("vm:entry-point")
  Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
    // Your code goes here
  }

  /// Use this method to detect when the user taps on a notification or action button
  @pragma("vm:entry-point")
  Future<void> onActionReceivedMethod(ReceivedAction receivedAction) async {
    // this method to add the patient record to the dashborad so the dashboard
    // makes alarm if the nurse didnt get the
    final now = DateTime.now();
    final DateTime createddate = receivedAction.createdDate!;
    final difference = now.difference(createddate).inSeconds;
    var docid = receivedAction.payload!["data"]!;
    if (difference > secondstomakealarm) {
      var docid = receivedAction.payload!["data"]!;
      await FirebaseDatabase.instance
          .ref()
          .child("/dashboard")
          .child(docid)
          .remove();
    } else {
      Future.delayed(
        Duration(seconds: secondstomakealarm + 1 - difference),
        () async {
          await FirebaseDatabase.instance
              .ref()
              .child("/dashboard")
              .child(docid)
              .remove();
        },
      );
    }
    // receivedAction.createdDate;
    makealarm = false;
    // Navigate into pages, avoiding to open the notification details page over another details page already opened
    navigatorKey.currentState?.push(MaterialPageRoute(
      builder: (context) => AddPatientVeiw(bedBarCode: docid),
    ));
  }
}
