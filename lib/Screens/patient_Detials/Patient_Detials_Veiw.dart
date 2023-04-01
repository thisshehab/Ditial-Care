import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:patient_observing/Models/bed_model.dart';

import '../../Custom_Widgets/Circular_Indicator.dart';

class PatientDetialsVeiw extends StatelessWidget {
  const PatientDetialsVeiw({super.key, required this.bed});
  final Bed bed;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.ltr,
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: Get.height / 13,
                  ),
                  Text(
                    bed.patient_name!,
                    style: TextStyle(fontSize: Get.height / 23),
                  ),
                  Text(
                    "الغرفة رقم ${bed.room_number} - السرير رقم ${bed.bed_number}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black, fontSize: Get.height / 40),
                  ),
                ],
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Container(
                            child: Text(
                              "Temperature",
                              style: TextStyle(fontSize: 30),
                            ),
                          ),
                          Container(
                            height: Get.height / 4,
                            width: Get.width / 2.5,
                            child: CircularIndicator(
                              sign: "ºC",
                              title: "Temperature",
                              input: 100,
                              max: 100,
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
                              style: TextStyle(fontSize: 30),
                            ),
                          ),
                          Container(
                            height: Get.height / 4,
                            width: Get.width / 2.5,
                            child: CircularIndicator(
                              sign: "bpm",
                              title: "Heart Rate",
                              input: 60,
                              max: 100,
                              min: 0,
                              padding: 0,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Container(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Container(
                            child: Text(
                              "Blood Oxygen",
                              style: TextStyle(fontSize: 30),
                            ),
                          ),
                          Container(
                            height: Get.height / 4,
                            width: Get.width / 2.5,
                            child: CircularIndicator(
                              sign: "%",
                              title: "Blood Oxygen",
                              input: 50,
                              max: 100,
                              min: 0,
                              padding: 0,
                            ),
                          ),
                        ],
                      ),
                      // Container(
                      //   height: Get.height / 4,
                      //   width: Get.width / 2.5,
                      //   child: CircularIndicator(
                      //     title: "Blood Pressure",
                      //     sign: "/",
                      //     input: 80,
                      //     max: 100,
                      //     min: 0,
                      //     padding: 0,
                      //   ),
                      // )
                    ],
                  )
                ],
              ),
              Container()
            ],
          ),
        ),
      ),
    );
  }
}
