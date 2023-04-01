import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:patient_observing/AppConstants/fonts.dart';
import 'package:patient_observing/Custom_Widgets/Textfeild.dart';
import 'package:patient_observing/Models/patient_model.dart';
import 'package:patient_observing/Screens/Patients_List_History/patients_list_modelVeiw.dart';
import 'package:patient_observing/User_Information/userInfo.dart';
import 'package:patient_observing/report/report.dart';

import '../../Animations/animating_widgets.dart';
import '../../AppConstants/color.dart';
import '../../Firebase/patient_FireBase.dart';

class PatientHistoryList extends StatefulWidget {
  const PatientHistoryList({super.key});

  @override
  State<PatientHistoryList> createState() => _PatientListState();
}

class _PatientListState extends State<PatientHistoryList> {
  TextEditingController _searchContrller = TextEditingController();
  PatientHistoryListModelVeiw _controller =
      PatientHistoryListModelVeiw(repository: Patients_FireBase());
  String searchText = "";
  bool loading = false;
  List<BasicPatientInfo>? data;
  getdata() async {
    loading = true;
    setState(() {});
    try {
      data!.clear();
    } catch (e) {
      print(e);
    }
    data = await _controller.get_all_patients(User.userId!, searchText);
    loading = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    double title = MediaQuery.of(context).textScaleFactor * Fonts.title;
    double subtitle = MediaQuery.of(context).textScaleFactor * Fonts.subtitle;
    double paragraph = MediaQuery.of(context).textScaleFactor * Fonts.paragraph;

    return Scaffold(
        appBar: AppBar(
            backgroundColor: MyColor.green2,
            title: Text(
              _controller.title,
              style: TextStyle(fontSize: title),
            )),
        body: Column(
          children: [
            loading || data == null
                ? Container(
                    alignment: Alignment.topCenter,
                    child: LinearProgressIndicator(
                      color: MyColor.green4,
                      backgroundColor: MyColor.green3,
                      minHeight: 4,
                    ),
                  )
                : Container(
                    height: 4,
                  ),
            Padding(
              padding: EdgeInsets.all(Get.height / 50),
              child: MyTextFeild(
                hintText: "البحث بالأسم",
                textController: _searchContrller,
                icon: const Icon(Icons.search),
                issecure: false,
                validate: (val) {},
                onchage: (value) {
                  searchText = value!;
                  getdata();
                  setState(() {});
                },
              ),
            ),
            Expanded(
                child: ListView.builder(
              itemCount: data == null ? 0 : data!.length,
              itemBuilder: (context, index) {
                BasicPatientInfo patient = data![index];
                return AnimationConfiguration.staggeredList(
                  position: index,
                  delay: const Duration(milliseconds: 500),
                  duration: const Duration(milliseconds: 500),
                  child: FadeInAnimation(
                    duration: const Duration(milliseconds: 500),
                    child: Container(
                      margin: EdgeInsets.only(
                          top: Get.height / 70,
                          left: Get.width / 49,
                          right: Get.width / 49),
                      decoration: BoxDecoration(
                        color: MyColor.blue2,
                      ),
                      child: ListTile(
                        title: Row(
                          children: [
                            AnimatedOpacityAndPosition(
                              delayduration:
                                  Duration(milliseconds: index * 500),
                              duration: Duration(milliseconds: 400),
                              offset: Offset.zero,
                              scale: 0.85,
                              withopacty: true,
                              reverse: false,
                              child: Image.asset(
                                "images/patient.png",
                                width: Get.width / 6,
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Text(
                                      "الاسم:  ${patient.name!}",
                                      style: TextStyle(fontSize: subtitle),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Text(
                                      "العمر:  ${patient.age.toString()}",
                                      style: TextStyle(fontSize: subtitle),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          IconButton(
                                            onPressed: () async {
                                              print(patient.id!);
                                              List<PatientSigns> signs =
                                                  await _controller
                                                      .get_patient_signs(
                                                          patient.id!);
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Report(
                                                            dangourse: false,
                                                            patientAge: patient
                                                                .age
                                                                .toString(),
                                                            patientName:
                                                                patient.name!,
                                                            patientSigns: signs,
                                                            reportTitle:
                                                                "تقرير شامل بعلامات المريض الحيوية",
                                                          )));
                                            },
                                            icon: const Icon(
                                                Icons.cloud_download_outlined),
                                          ),
                                          Text(
                                            "تقرير شامل",
                                            style:
                                                TextStyle(fontSize: subtitle),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
                                            onPressed: () async {
                                              print(patient.id!);
                                              List<PatientSigns> signs =
                                                  await _controller
                                                      .get_patient_signs(
                                                          patient.id!);
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Report(
                                                            dangourse: true,
                                                            patientAge: patient
                                                                .age
                                                                .toString(),
                                                            patientName:
                                                                patient.name!,
                                                            patientSigns: signs,
                                                            reportTitle:
                                                                "تقرير شامل بعلامات المريض الحيوية",
                                                          )));
                                            },
                                            icon: Icon(
                                                Icons.cloud_download_outlined),
                                          ),
                                          Text(
                                            "تقرير بالاضطرابات",
                                            style:
                                                TextStyle(fontSize: subtitle),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            )),
          ],
        ));
  }
}
