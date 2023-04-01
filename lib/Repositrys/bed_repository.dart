// ignore_for_file: non_constant_identifier_names

import '../Models/bed_model.dart';

abstract class BedRepository {
  Stream<List<Bed>> get_nurse_patients(String nurse_Id);
  Stream<List<Bed>> get_doctor_patients(String doctor_Id);
  Stream<Bed> get_single_patient_as_stream(String bedId);
  Future<Bed?> get_single_patient(String bedId);
  Stream<List<Bed>> get_all_patients();
  Stream<List<Bed>> get_all_patients_byRomm(int roomNumber);
  Future<Map<String, String>> insert_patient(Bed patient, String bedId);
  Future<Map<String, String>> update_patient_by_nurse(String nurseId, String bedId,String patientId);
  void update_patient(String nodeid);
  void delete_patient(String bed_Id);
  Future<List<String>> getallbeds();
}
