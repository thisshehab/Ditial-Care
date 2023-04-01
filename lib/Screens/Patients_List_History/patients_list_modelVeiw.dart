import 'package:patient_observing/Models/patient_model.dart';
import 'package:patient_observing/Repositrys/patient_repository.dart';
import 'package:patient_observing/report/report.dart';

class PatientHistoryListModelVeiw {
  String title = "تسجيلات حالات المرضى";
  final PatientRepository repository;
  PatientHistoryListModelVeiw({required this.repository});

  Future<List<BasicPatientInfo>> get_all_patients(
      String userId, String searchText) {
    return repository.get_All_Patient_Basic_Info(userId, searchText);
  }

  Future<List<PatientSigns>> get_patient_signs(String patientId) {
    return repository.get_single_Patient_Signs(patientId);
  }
}
