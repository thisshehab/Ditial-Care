import 'package:patient_observing/Models/doctor_model.dart';
// ignore_for_file: non_constant_identifier_names

abstract class DoctorRepository {
  Future<List<Doctor>> get_all_doctors();
  Future<Map<String, String>> insert_doctor(Map<dynamic, dynamic> data);
  Future<Map<String, String>> update_doctor(
      String docid, Map<String, String> data);
  Future<Map<String, String>> delete_doctor(String docid);
  Future<List<Doctor>?> is_avialable(String username, String password);
}
