import 'package:get/get.dart';
import 'package:patient_observing/Models/doctor_model.dart';
import 'package:patient_observing/Repositrys/doctor_repository.dart';

import '../../../Models/nurse_model.dart';
import '../../../Repositrys/nurse_repository.dart';

class SignUpModelVeiw extends GetxController {
  String username = "اسم المستخدم";
  String hintname = "أدخل اسم مستخدم صحيح";
  String realhint = "الأسم";
  String pagetitle = "إنشاء مستخدم";

  String hintusername = "أدخل أسم صحيح";
  String signUpString = "إنشاء حساب";
  String userTypeString = "نوع المستخدم :";
  String passwrod = "كلمة المرور";

  SignUpModelVeiw(
      {required this.doctorRepository, required this.nurseRepository});
  final DoctorRepository doctorRepository;
  final NurseRepository nurseRepository;
  String nurse = "nurse";
  String doctor = "doc";

  String? nameValidation(value) {
    RegExp nameRegex = RegExp('');

    if (nameRegex.hasMatch(value!)) {
      return null;
    }
    return hintname;
  }

  String? userNameValidation(value) {
    RegExp nameRegex = RegExp(r'^\S*$');

    if (nameRegex.hasMatch(value!)) {
      return null;
    }
    return hintusername;
  }
  // ignore: non_constant_identifier_names
  Future<Map<String, String>> insert_User(
      Map<String, dynamic> user, type) async {
    if (type == doctor) {
      Doctor doc = Doctor.fromJson(user, "");
      return doctorRepository.insert_doctor(doc.toJson(doc));
    } else if (type == nurse) {
      Nurse nurse = Nurse.fromJson(user, "");
      return nurseRepository.insert_Nurse(nurse.toJson(nurse));
    } else {
      return {"status": "no type"};
    }
  }

  // method(){
  //       FirebaseDatabase.instance.ref().child('/Bed').onValue.listen((event) {
  //   Map<dynamic, dynamic> values =
  //       event.snapshot.value as Map<dynamic, dynamic>;
  //   if (values != null) {
  //     values.forEach((key, value) {
  //       Map<String, dynamic> data = Map<String, dynamic>.from(value);
  //       // data['id'] = key; // Add the key as an 'id' field in the map
  //       // dataList.add(data);
  //       mydataList.add(Bed.fromJson(data, key));
  //       // update();
  //     });
  //   }
  //   print(mydataList);
  // });
  // }
}
