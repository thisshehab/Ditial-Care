import 'package:patient_observing/Models/patient_model.dart';

abstract class PatientRepository {
  // ignore: non_constant_identifier_names
  Future<List<BasicPatientInfo>> get_All_Patient_Basic_Info(String id,String search);
  // ignore: non_constant_identifier_names
  Future<List<PatientSigns>> get_single_Patient_Signs(String id);
  Future<Map<String, String>> insert_patient(String id,BasicPatientInfo patientInfo);
  Future<Map<String, String>> insert_patient_signs(String id,PatientSigns patientSigns);
}
