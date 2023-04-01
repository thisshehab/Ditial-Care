import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:patient_observing/Models/patient_model.dart';
import 'package:intl/intl.dart';
import '../Repositrys/patient_repository.dart';

// ignore: camel_case_types
class Patients_FireBase extends PatientRepository {
  // ignore: non_constant_identifier_names
  FirebaseFirestore database = FirebaseFirestore.instance;
  @override
  // ignore: non_constant_identifier_names
  Future<List<BasicPatientInfo>> get_All_Patient_Basic_Info(
      String id, String search) async {
    List<BasicPatientInfo> patients = [];
    await database
        .collection("Patients")
        .where('Name', isGreaterThanOrEqualTo: search)
        .where('Name', isLessThan: search + '\uf8ff')
        .get()
        .then((value) {
      for (var element in value.docs) {
        patients.add(BasicPatientInfo.fromJson(element.data(), element.id));
      }
    });

    return patients;
  }

  @override
  // ignore: non_constant_identifier_names
  Future<List<PatientSigns>> get_single_Patient_Signs(String id) async {
    List<PatientSigns> signs = [];
    var collection = database.collection("P_History");
    await collection.doc(id).collection("Signs").get().then((value) {
      value.docs.map((element) {
        signs.add(PatientSigns.fromJson(element.data(), element.id));
      }).toList();
    });
    return signs;
  }

  @override
  // ignore: non_constant_identifier_names
  Future<Map<String, String>> insert_patient(
      // ignore: avoid_renaming_method_parameters
      String id,
      BasicPatientInfo basicPatientInfo) async {
    Map<String, String> status = {"status": "fial"};
    var collection = database.collection("Patients");
    await collection
        .doc(id)
        .set(basicPatientInfo.toJson(basicPatientInfo))
        .then((value) {
      status["status"] = "success";
    });
    return status;
  }

  @override
  // ignore: non_constant_identifier_names
  Future<Map<String, String>> insert_patient_signs(
      String id, PatientSigns patientSigns) async {
    DateTime now = DateTime.now();
    Map<String, String> status = {"status": "fial"};
    String formattedDate = DateFormat('dd-MM-yyyy mm:hh').format(now);
    var collection = database.collection("P_History");
    await collection
        .doc(id)
        .collection("Signs")
        .doc(formattedDate)
        .set(patientSigns.toJson(patientSigns))
        .then((value) {
      status["status"] = "success";
    });
    return status;
  }
}
