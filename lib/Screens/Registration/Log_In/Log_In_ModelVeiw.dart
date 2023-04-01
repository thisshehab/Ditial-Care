import 'package:get/get.dart';
import 'package:patient_observing/Models/doctor_model.dart';
import 'package:patient_observing/Repositrys/doctor_repository.dart';
import 'package:patient_observing/User_Information/userInfo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Models/nurse_model.dart';
import '../../../Repositrys/nurse_repository.dart';

class LogInModelVeiw extends GetxController {
  LogInModelVeiw(
      {required this.doctorRepository, required this.nurseRepository});
  final DoctorRepository doctorRepository;
  final NurseRepository nurseRepository;
  String nurse = "nurse";
  String doctor = "doc";
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

  Future<Map<String, String>> isAvialble(
      Map<String, String> user, String type) async {
    final prefs = await SharedPreferences.getInstance();
    if (type == doctor) {
      List<Doctor>? doctor = await doctorRepository.is_avialable(
          user["username"]!, user["Password"]!);
      if (doctor != null && doctor.isNotEmpty) {
        await prefs.setString('UserId', doctor[0].nodeId!);
        await prefs.setString('UserName', doctor[0].name!);
        await prefs.setString('username', doctor[0].username!);
        User.username = doctor[0].username!;
        User.userId = doctor[0].nodeId!;
        User.userName = doctor[0].name!;
        print(doctor[0].nodeId!);
        return {"status": "success"};
      } else {
        return {"status": "fial"};
      }
    } else {
      List<Nurse>? nurse = await nurseRepository.is_avialable(
          user["username"]!, user["Password"]!);
      if (nurse != null) {
        await prefs.setString('UserId', nurse[0].nodeId!);
        await prefs.setString('UserName', nurse[0].name!);
        await prefs.setString('username', nurse[0].username!);
        User.username = nurse[0].username!;
        User.userId = nurse[0].nodeId!;
        User.userName = nurse[0].name!;
        print("welcome>>>>>>>>>>>>>>>>>>>>>>>>>");
        return {"status": "success"};
      } else {
        return {"status": "fial"};
      }
    }
  }
}
