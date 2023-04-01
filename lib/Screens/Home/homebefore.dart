import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:patient_observing/AppConstants/strings.dart';
import 'package:patient_observing/AppConstants/variables.dart';
import 'package:patient_observing/Custom_Widgets/Button.dart';
import 'package:patient_observing/Firebase/beds_FireBase.dart';
import 'package:patient_observing/Screens/Add_Patient/Add_Patient_Veiw.dart';
import 'package:patient_observing/Screens/Home/drawer.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../Animations/animating_widgets.dart';
import '../../Other/Local_Notification.dart';
import '../../Other/awsomenoti.dart';
import 'package:intl/intl.dart';

import '../../listener/statusListener.dart';
import '../Patients/patients_Veiw2.dart';
import 'home_ModelVeiw.dart';

final FlutterTts flutterTts = FlutterTts();

// Future _speak() async{
//     var result = await flutterTts.speak("Hello World");
//     if (result == 1) setState(() => ttsState = TtsState.playing);
// }

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  HomePageController _controller = HomePageController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    PatientStatusListener(data: BedsFromFirebase(local: Variables.fromLocal))
        .listen();
    // Notifications(title: "حالة طارئة", body: "الغرفة رقم ").showNotification();
  }



  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    AwesomeNotifications().dispose();
  }

  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addObserver(this);
  // }

  // @override
  // void dispose() {
  //   WidgetsBinding.instance.removeObserver(this);
  //   super.dispose();
  // }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   super.didChangeAppLifecycleState(state);
  //   if (state == AppLifecycleState.resumed) {
  //     print("App is running!");
  //   } else if (state == AppLifecycleState.paused) {
  //     print("App is paused!");
  //   } else if (state == AppLifecycleState.detached) {
  //     Workmanager().registerPeriodicTask("task-identifier", "simpleTask",
  //         frequency: Duration(minutes: 15));
  //   }
  // }
  int number = 1;
  TextEditingController username = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(child: MyDrawer()),
        body: GetBuilder<HomePageController>(
            init: HomePageController(),
            builder: (controller) {
              return Column(
                children: [
                  SizedBox(
                    height: 35,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Builder(builder: (context) {
                        return AnimatedOpacityAndPosition(
                          scale: 1,
                          reverse: controller.reverse,
                          delayduration: Duration(milliseconds: 200),
                          offset: Offset(.1, 0),
                          withopacty: true,
                          child: InkWell(
                              onTap: () {
                                Scaffold.of(context).openDrawer();
                              },
                              child: Container(
                                  margin: EdgeInsets.only(right: 9),
                                  child: Image.asset(
                                    "images/menu.png",
                                    height: 50,
                                  ))),
                        );
                      }),
                      Row(
                        children: [
                          AnimatedOpacityAndPosition(
                            scale: 1,
                            reverse: controller.reverse,
                            delayduration: Duration(milliseconds: 200),
                            offset: Offset(0, 0),
                            withopacty: true,
                            child: VxBadge(
                              color: Colors.red,
                              size: 15,
                              child: GestureDetector(
                                onTap: () {},
                                child: Image.asset(
                                  "images/bell.png",
                                  height: 32,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          AnimatedOpacityAndPosition(
                            scale: 1,
                            reverse: controller.reverse,
                            delayduration: Duration(milliseconds: 200),
                            offset: Offset(0, 0),
                            withopacty: true,
                            child: GestureDetector(
                              onTap: () {},
                              child: Image.asset(
                                Strings.doctorimage,
                                height: 50,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 19,
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: Get.height / 45,
                  ),
                  AnimatedOpacityAndPosition(
                    scale: 1,
                    reverse: controller.reverse,
                    delayduration: Duration(milliseconds: 300),
                    offset: Offset(0, 0),
                    withopacty: true,
                    child: Container(
                      padding: EdgeInsets.only(right: 20, top: 20),
                      alignment: Alignment.topRight,
                      child: Text(
                        "أهلًا شهاب محمد ",
                        style: TextStyle(fontSize: Get.height / 35),
                      ),
                    ),
                  ),
                  AnimatedOpacityAndPosition(
                    scale: .9,
                    reverse: controller.reverse,
                    delayduration: Duration(milliseconds: 400),
                    offset: Offset(0, 0),
                    withopacty: true,
                    curve: Curves.easeOutQuart,
                    child: InkWell(
                        onTap: scanBarcode,
                        child: Container(
                            height: Get.height / 2.3,
                            child:
                                Lottie.asset("images/123090-qr-scanner.json"))),
                  ),
                  AnimatedOpacityAndPosition(
                    scale: 1,
                    reverse: controller.reverse,
                    delayduration: Duration(milliseconds: 500),
                    offset: Offset(0, .1),
                    withopacty: true,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                        "استخدم الباركود لعرض معلومات أو لتغيير المريض",
                        style: TextStyle(fontSize: Get.height / 40),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height / 12,
                  ),
                  AnimatedOpacityAndPosition(
                    scale: .9,
                    reverse: controller.reverse,
                    curve: Curves.easeOutQuart,
                    delayduration: Duration(milliseconds: 600),
                    offset: Offset(0, 0),
                    withopacty: true,
                    child: GradientButtonFb4(
                      onPressed: () {
                        controller.reverseanimation(true);
                        Future.delayed(
                          Duration(milliseconds: 900),
                          () async {
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.fade,
                                    child: PatientsVeiw()));
                          },
                        );
                      },
                      text: "عرض الحالات المستلمة",
                    ),
                  ),
                  // SizedBox(
                  //   height: 40,
                  // ),
                  // AnimatedOpacityAndPosition(
                  //   scale: .9,
                  //   reverse: controller.reverse,
                  //   curve: Curves.easeOutQuart,
                  //   delayduration: Duration(milliseconds: 600),
                  //   offset: Offset(0, 0),
                  //   withopacty: true,
                  //   child: GradientButtonFb4(
                  //     onPressed: () {

                  //     },
                  //     text: "انذار كاذب",
                  //   ),
                  // )
                ],
              );
            }));
  }

  // void method() {
  //   Workmanager()
  //       .registerPeriodicTask("uniqueName", "hi")
  //       .then((value) => print("hi mother father"));
  // }
  Future<void> scanBarcode() async {
    String? barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
      "#FF0000", // color of the toolbar
      "خروج", // text of the cancel button
      false, // show flash icon
      ScanMode.QR, // scanning mode
    );
    if (barcodeScanRes != '-1') {
      // Handle barcode result
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => AddPatientVeiw(
          bedBarCode: barcodeScanRes,
        ),
      ));
    }
  }
}
