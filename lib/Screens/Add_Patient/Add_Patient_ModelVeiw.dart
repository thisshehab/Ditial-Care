import 'dart:async';

import 'package:get/get.dart';
import 'package:patient_observing/Models/bed_model.dart';
import 'package:patient_observing/Repositrys/bed_repository.dart';

class AddPatient_ModelVeiw {
  final BedRepository database;

  AddPatient_ModelVeiw(this.database);

  Future<Map<String, String>> addPatient(
      {required Bed patient, required String barcode}) {
    return database.insert_patient(patient, barcode);
  }

  Future<Bed?> getsinglepatient({required String barcode}) {
    return database.get_single_patient(barcode);
  }

  Bed? patient;
  Stream<Bed> getpatientasstream({required String barcode}) {
    return database.get_single_patient_as_stream(barcode);
  }

  update_patient_by_nurse(String nurseId, String bedId, String patientId) {
    return database.update_patient_by_nurse(nurseId, bedId, patientId);
  }
}
