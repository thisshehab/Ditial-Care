// import 'package:background_fetch/background_fetch.dart';
import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:patient_observing/AppConstants/strings.dart';
import 'package:patient_observing/Screens/Home/home.dart';
import 'package:patient_observing/Screens/Registration/Log_In/Log_In_Veiw.dart';
import 'package:patient_observing/User_Information/userInfo.dart';
import 'package:patient_observing/report/report.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';
import 'Other/awsomenoti.dart';
import 'Screens/Home/homebefore.dart';
import 'Screens/Patients_List_History/patients_list.dart';
import 'Screens/Registration/Sign_Up/SignUp_Veiw.dart';
import 'Screens/onboarding/onboarding.dart';

void callbackDispatcher() async {
  Workmanager().executeTask((task, inputData) async {
    print("hi there its me");
    return Future.value(true);
  });
}

void main() async {
  await AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
          channelKey: 'basic channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          importance: NotificationImportance.Max,
          channelShowBadge: true)
    ],
    debug: true,
  );
  WidgetsFlutterBinding.ensureInitialized();

  Workmanager().initialize(
      callbackDispatcher, // The top level function, aka callbackDispatcher
      isInDebugMode:
          true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks

      );
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  final shared = await SharedPreferences.getInstance();
  User.userId = shared.getString("UserId");
  User.username = shared.getString("username");
  User.userName = shared.getString("UserName");
  // final String host = Platform.isAndroid ? "http://192.168.1.102:5002" : "";
  // final String name = "patient-observing1";

  // FirebaseOptions options = FirebaseOptions(
  //   apiKey: "",
  //     appId: "",
  //     messagingSenderId: "",
  //     projectId: "",
  //     databaseURL: "$host?ns=$name");

  await Firebase.initializeApp();
  runApp(const MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AwesomeNotifications().setListeners(
        onActionReceivedMethod: NotificationController().onActionReceivedMethod,
        onNotificationCreatedMethod:
            NotificationController().onNotificationCreatedMethod,
        onNotificationDisplayedMethod:
            NotificationController().onNotificationDisplayedMethod,
        onDismissActionReceivedMethod:
            NotificationController().onDismissActionReceivedMethod);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,

      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child!,
        );
      },
      onGenerateRoute: (settings) {},

      routes: {
        "/SignUp": (context) => const SignUp(),
        "/LogIn": (context) => LogIn(),
        "/home": (context) => HomePage(),
        "/onboarding": (context) => OnBoardingPage(),
        // "/pdf": (context) => Report(),
        "/patientshistorylist": (context) => const PatientHistoryList()
      },
      title: Strings.appname,
      initialRoute: User.username == null ? "/onboarding" : "/home",
      // initialRoute: "/patientshistorylist",
      // initialRoute: "/LogIn",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Vazirmatn-VariableFont_wght",
        textTheme: TextTheme(),
        primarySwatch: Colors.green,
        useMaterial3: true,
      ),
    );
  }
}
