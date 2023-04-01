import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:patient_observing/AppConstants/color.dart';
import 'package:patient_observing/AppConstants/variables.dart';
import 'package:patient_observing/Firebase/beds_FireBase.dart';
import 'package:patient_observing/User_Information/userInfo.dart';
import '../../Custom_Widgets/Button.dart';
import '../../Custom_Widgets/Circular_Indicator.dart';
import '../../Custom_Widgets/Textfeild.dart';
import '../../Models/bed_model.dart';
import 'Add_Patient_ModelVeiw.dart';

class AddPatientVeiw extends StatefulWidget {
  final String bedBarCode;
  const AddPatientVeiw({super.key, required this.bedBarCode});

  @override
  State<AddPatientVeiw> createState() => _AddPatientVeiwState();
}

class _AddPatientVeiwState extends State<AddPatientVeiw> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeData();
  }

  Bed? patient;
  bool loading = true;
  initializeData() async {
    loading = true;
    patient = await _controller.getsinglepatient(barcode: widget.bedBarCode);
    if (patient != null) {
      pateintNameController.text = patient!.patient_name!;
      pateintAgeController.text = patient!.patient_age!.toString();
      roomNumber.text = patient!.room_number!.toString();
      bedNumber.text = patient!.bed_number!.toString();
      update_nurse();
      setState(() {});
    }
    loading = false;
    setState(() {});
  }

  update_nurse() {
    _controller.update_patient_by_nurse(
        User.userId!, widget.bedBarCode, patient!.patient_Id!);
  }

  TextEditingController pateintNameController = TextEditingController();
  TextEditingController pateintAgeController = TextEditingController();
  TextEditingController roomNumber = TextEditingController();
  TextEditingController bedNumber = TextEditingController();
  final AddPatient_ModelVeiw _controller =
      AddPatient_ModelVeiw(BedsFromFirebase(local: Variables.fromLocal));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColor.green2,
        title: Text(patient == null ? "إضافة مريض" : "عرض الحالة"),
      ),
      body: loading
          ? LinearProgressIndicator(
              color: MyColor.green4,
              backgroundColor: MyColor.green3,
            )
          : Padding(
              padding: EdgeInsets.only(
                  right: Get.width / 24,
                  left: Get.width / 24,
                  top: Get.height / 30),
              child: ListView(
                children: [
                  patient != null ? statusDetials() : Container(),
                  MyTextFeild(
                    hintText: "أسم المريض",
                    icon: const Icon(Icons.person),
                    textController: pateintNameController,
                    validate: (p0) {},
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  MyTextFeild(
                    hintText: "سن المريض",
                    texttype: TextInputType.number,
                    icon: const Icon(Icons.assignment_ind_outlined),
                    textController: pateintAgeController,
                    validate: (p0) {},
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: Get.width / 2.5,
                        child: MyTextFeild(
                          texttype: TextInputType.number,
                          hintText: "رقم الغرفة",
                          icon: const Icon(Icons.door_sliding_sharp),
                          textController: roomNumber,
                          validate: (p0) {},
                        ),
                      ),
                      SizedBox(
                        width: Get.width / 2.5,
                        child: MyTextFeild(
                          texttype: TextInputType.number,
                          hintText: "رقم السرير",
                          icon: const Icon(Icons.bed),
                          textController: bedNumber,
                          validate: (p0) {},
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Get.height / 25,
                  ),
                  GradientButtonFb4(
                    onPressed: () async {
                      Random rand = Random();
                      int patientid = rand.nextInt(1000000);
                      Bed patient2 = Bed.fromJson({
                        "Id": widget.bedBarCode,
                        "Number": int.parse(bedNumber.text),
                        "P_Id": patientid.toString(),
                        "B_state": false,
                        "BP_Max": 10,
                        "Doc_Id": "10",
                        "HR": 90,
                        "Nurse_Id": User.userId,
                        "Age": int.parse(pateintAgeController.text),
                        "SPO2": 97,
                        "Name": pateintNameController.text,
                        "Room_Number": int.parse(roomNumber.text),
                        "Temp": 37.3,
                        "BP_Min": 20
                      }, "sdlkf");
                      Map<String, String> value = await _controller.addPatient(
                          patient: patient2, barcode: widget.bedBarCode);
                      if (value["status"] == "success") {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("نجحت العملية !"),
                              icon: Lottie.asset("images/success.json",
                                  width: Get.height / 26),
                            );
                          },
                        );
                        patient = patient2;
                        setState(() {});
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("فشلت العملية !"),
                              icon: Lottie.asset("images/fail.json",
                                  width: Get.height / 26),
                            );
                          },
                        );
                      }
                    },
                    text: patient == null ? "إضافة المريض" : "تعديل البيانات",
                  ),
                ],
              ),
            ),
    );
  }

  statusDetials() {
    // _controller.getpatientasstream(barcode: widget.bedBarCode);
    // Bed patient = _controller.patient!;
    _controller.getpatientasstream(barcode: widget.bedBarCode).listen((event) {
      patient = event;
      setState(() {});
    });
    return Container(
        height: Get.height / 4.5,
        padding: EdgeInsets.only(bottom: Get.height / 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                  child: Text(
                    "Temperature",
                    style: TextStyle(fontSize: Get.width / 20),
                  ),
                ),
                Container(
                  height: Get.height / 6,
                  width: Get.width / 4,
                  child: CircularIndicator(
                    sign: "Cº",
                    title: "Temperature",
                    input: patient!.temp!.toDouble(),
                    max: 100,
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
                Container(
                  height: Get.height / 6,
                  width: Get.width / 4,
                  child: CircularIndicator(
                    sign: "%",
                    title: "SPO2",
                    input: patient!.spo2!.toDouble(),
                    max: 200,
                    min: 0,
                    padding: 0,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  child: Text(
                    "Heart Rate",
                    style: TextStyle(fontSize: Get.width / 20),
                  ),
                ),
                Container(
                  height: Get.height / 6,
                  width: Get.width / 4,
                  child: CircularIndicator(
                    sign: "bpm",
                    title: "Heart Rate",
                    input: patient!.hr!.toDouble(),
                    max: 100,
                    min: 0,
                    padding: 0,
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
