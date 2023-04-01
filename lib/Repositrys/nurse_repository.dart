import 'package:patient_observing/Models/nurse_model.dart';
// ignore_for_file: non_constant_identifier_names

abstract class NurseRepository {
  Future<List<Nurse>> get_all_Nurses();
  Future<Map<String, String>> insert_Nurse(Map<dynamic, dynamic> data);
  Future<Map<String, String>> update_Nurse(
      String docid, Map<String, String> data);
  Future<Map<String, String>> delete_Nurse(String docid);
  Future<List<Nurse>?> is_avialable(String username, String password);
}
