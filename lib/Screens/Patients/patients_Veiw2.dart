// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:patient_observing/AppConstants/color.dart';
import 'package:patient_observing/AppConstants/variables.dart';
import 'package:patient_observing/Custom_Widgets/Expand_Widget.dart';
import 'package:patient_observing/Firebase/beds_FireBase.dart';
import 'package:patient_observing/Models/bed_model.dart';
import 'package:patient_observing/Screens/Patients/patients_ModelVeiw.dart';
import 'package:patient_observing/User_Information/userInfo.dart';
import '../../Custom_Widgets/Circular_Indicator.dart';
import '../Home/home_ModelVeiw.dart';

class PatientsVeiw extends StatefulWidget {
  const PatientsVeiw({super.key});
  @override
  State<PatientsVeiw> createState() => _PatientsVeiwState();
}

class _PatientsVeiwState extends State<PatientsVeiw> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageController>(
        init: HomePageController(),
        builder: (homecontrller) {
          return WillPopScope(
            onWillPop: () async {
              homecontrller.reverseanimation(false);
              return true;
            },
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: MyColor.green2,
                // elevation: 100,
                title: const Text("قائمة المرضى"),
              ),
              body: GetBuilder<PatientController>(
                  init: PatientController(
                      repository: BedsFromFirebase(local: Variables.fromLocal)),
                  builder: (controller) {
                    return FutureBuilder(
                      future: controller.getroomnumbers(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Container(
                            alignment: Alignment.topCenter,
                            child: LinearProgressIndicator(
                              color: MyColor.green4,
                              backgroundColor: MyColor.green3,
                              minHeight: 4,
                            ),
                          );
                        }
                        if (!snapshot.hasData) {
                          return const Center(
                            child: Text("لا يوجد مرضى حاليًا"),
                          );
                        } else {
                          return Column(
                            children: [
                              SizedBox(
                                height: Get.height / 40,
                              ),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    List<String> rooms = snapshot.data!;
                                    return AnimationConfiguration.staggeredList(
                                      position: index,
                                      delay: const Duration(milliseconds: 300),
                                      duration:
                                          const Duration(milliseconds: 500),
                                      child: SlideAnimation(
                                        horizontalOffset: -30,
                                        curve: Curves.fastLinearToSlowEaseIn,
                                        duration:
                                            const Duration(milliseconds: 500),
                                        child: FadeInAnimation(
                                          curve: Curves.fastLinearToSlowEaseIn,
                                          duration:
                                              const Duration(milliseconds: 500),
                                          child: ExpandWidget(
                                              color: MyColor.realorange,
                                              padding: const EdgeInsets.only(
                                                  right: 15,
                                                  left: 15,
                                                  bottom: 10),
                                              // ignore: sort_child_properties_last
                                              child: StreamBuilder(
                                                stream: controller.getpatients(
                                                    User.userId!,
                                                    int.parse(rooms[index])),
                                                builder:
                                                    (context, secondsnapshot) {
                                                  if (secondsnapshot
                                                          .connectionState ==
                                                      ConnectionState.waiting) {
                                                    // ignore: sized_box_for_whitespace
                                                    return Container(
                                                      height: 10,
                                                      child:
                                                          LinearProgressIndicator(
                                                        minHeight: 10,
                                                        color: MyColor.green4,
                                                        backgroundColor:
                                                            MyColor.green3,
                                                      ),
                                                    );
                                                  }
                                                  if (!secondsnapshot.hasData) {
                                                    return const Center(
                                                      child: Text(
                                                          "لا يوجد مرضى حاليًا"),
                                                    );
                                                  }
                                                  List<Bed> secondbed =
                                                      secondsnapshot.data!;
                                                  return Column(
                                                    children: secondbed
                                                        .map(
                                                            (patient) =>
                                                                SlideAnimation(
                                                                  horizontalOffset:
                                                                      -30,
                                                                  curve: Curves
                                                                      .fastLinearToSlowEaseIn,
                                                                  duration: const Duration(
                                                                      milliseconds:
                                                                          700),
                                                                  child:
                                                                      FadeInAnimation(
                                                                    curve: Curves
                                                                        .fastLinearToSlowEaseIn,
                                                                    duration: const Duration(
                                                                        milliseconds:
                                                                            700),
                                                                    child: ExpandWidget(
                                                                        color: MyColor.orange,
                                                                        padding: const EdgeInsets.only(right: 20, bottom: 20, left: 20),
                                                                        title: Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Text("الأسم: ${patient.patient_name.toString()}"),
                                                                            Text("رقم السرير: ${patient.bed_number.toString()}"),
                                                                            // Text(
                                                                            //     "العمر : ${patient.patient_age.toString()}"),
                                                                          ],
                                                                        ),
                                                                        child: patientsDetials(patient: patient)),
                                                                  ),
                                                                ))
                                                        .toList(),
                                                  );
                                                },
                                              ),
                                              title: Text(
                                                "الغرفة رقم ${rooms[index]}",
                                                style: TextStyle(
                                                    fontSize: Get.height / 49),
                                              )),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          );
                        }
                      },
                    );
                  }),
            ),
          );
        });
  }

  patientsDetials({required Bed patient}) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                "Temperature",
                style: TextStyle(fontSize: Get.width / 20),
              ),
              SizedBox(
                height: Get.height / 6,
                width: Get.width / 4,
                child: CircularIndicator(
                  sign: "Cº",
                  title: "Temperature",
                  input: patient.temp!.toDouble(),
                  max: 80,
                  min: 0,
                  padding: 0,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Text(
                "SPO2",
                style: TextStyle(fontSize: Get.width / 20),
              ),
              SizedBox(
                height: Get.height / 6,
                width: Get.width / 4,
                child: CircularIndicator(
                  sign: "%",
                  title: "SPO2",
                  input: patient.spo2!.toDouble(),
                  max: 200,
                  min: 0,
                  padding: 0,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Text(
                "Heart Rate",
                style: TextStyle(fontSize: Get.width / 20),
              ),
              SizedBox(
                height: Get.height / 6,
                width: Get.width / 4,
                child: CircularIndicator(
                  sign: "bpm",
                  title: "Heart Rate",
                  input: patient.hr!.toDouble(),
                  max: 200,
                  min: 0,
                  padding: 0,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
