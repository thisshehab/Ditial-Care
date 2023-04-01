import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:patient_observing/AppConstants/variables.dart';
import 'package:patient_observing/Firebase/beds_FireBase.dart';
import 'package:patient_observing/Firebase/doctors_FireBase.dart';
import 'package:patient_observing/Models/bed_model.dart';
import 'package:patient_observing/Models/doctor_model.dart';
import 'package:patient_observing/Repositrys/bed_repository.dart';

class HomePageController extends GetxController {
  // BedRepository beds;
  HomePageController();
  // Stream<List<Bed>> getallpatients() {
  //   return beds.get_all_patients();
  // }
  bool reverse = false;
  reverseanimation(bool myreverse) async {
    reverse = myreverse;
    update();
  }

  getdata() async {
    List<Doctor> data =
        await DoctorsFromFirebase(local: Variables.fromLocal).get_all_doctors();
    return data;
  }

  String _barcode = "";


}
