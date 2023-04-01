import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:patient_observing/AppConstants/color.dart';
import 'package:patient_observing/AppConstants/strings.dart';
import 'package:patient_observing/User_Information/userInfo.dart';

import '../../AppConstants/fonts.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    double title = MediaQuery.of(context).textScaleFactor * Fonts.subtitle;

    return Column(
      children: [
        // Container(
        //   padding: EdgeInsets.only(
        //     top: Get.height / 20,
        //   ),
        //   decoration: BoxDecoration(color: MyColor.green2, boxShadow: const [
        //     BoxShadow(
        //         color: Color.fromARGB(59, 0, 0, 0),
        //         blurRadius: 15,
        //         offset: Offset(3, 0))
        //   ]),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       Container(
        //         margin: EdgeInsets.only(right: Get.width / 30),
        //         width: Get.width / 2.5,
        //         child: Column(
        //           children: [
        //             Text(
        //               User.userName!,
        //               style: TextStyle(fontSize: Get.height / 45),
        //             ),
        //             SizedBox(
        //               height: Get.height / 50,
        //             ),
        //             Text(
        //               User.username!,
        //               style: TextStyle(fontSize: Get.width / 25),
        //             ),
        //           ],
        //         ),
        //       ),
        //       Image.asset(
        //         Strings.doctorimage,
        //         height: 120,
        //       )
        //     ],
        //   ),
        // ),
        SizedBox(
          height: Get.height / 15,
        ),
        ListTile(
          onTap: (() =>
              Navigator.of(context).pushNamed("/patientshistorylist")),
          tileColor: Colors.white,
          title: Text(
            "عرض المرضى",
            style: TextStyle(fontSize: title),
          ),
          leading: Icon(Icons.bed_rounded),
          trailing: Icon(Icons.arrow_forward),
        )
      ],
    );
  }
}
