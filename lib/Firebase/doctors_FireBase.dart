// ignore: file_names
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:patient_observing/Models/doctor_model.dart';
import 'package:patient_observing/Repositrys/doctor_repository.dart';

import '../AppConstants/variables.dart';

class DoctorsFromFirebase extends DoctorRepository {
  var database = FirebaseDatabase.instance.ref();
  final bool local;

  DoctorsFromFirebase({required this.local}) {
    if (local) {
      database = FirebaseDatabase.instanceFor(
              app: Firebase.app(), databaseURL: Variables.firebase_local_url)
          .ref();
    }
  }
  @override
  // ignore: non_constant_identifier_names
  Future<Map<String, String>> delete_doctor(String docid) async {
    try {
      var mydata = await database.child("/Doctors/$docid").remove();
      return {"status": "success"};
    } catch (e) {
      return {"status": "fail"};
    }
  }
// Set up a Realtime Database listener to listen for changes to the "users" node

  @override
  // ignore: non_constant_identifier_names
  Future<List<Doctor>> get_all_doctors() async {
    return await database.child("/Doctors").once().then((value) {
      List<Doctor> doctors = [];
      var data = value.snapshot.value as Map<dynamic, dynamic>;
      data.forEach((key, value) {
        doctors.add(Doctor.fromJson(value, key));
      });
      return doctors;
    });
  }

  @override
  // ignore: non_constant_identifier_names
  Future<Map<String, String>> insert_doctor(Map<dynamic, dynamic> data) async {
    try {
      await database.child("/Doctors").push().set(data);
      return {"status": "success"};
    } catch (e) {
      return {"status": "fail"};
    }
  }

  @override
  // ignore: non_constant_identifier_names
  Future<Map<String, String>> update_doctor(
      String docid, Map<String, String> data) async {
    try {
      await database.child("/Doctors/$docid").update(data);
      return {"status": "success"};
    } catch (e) {
      return {"status": "fail"};
    }
  }

  @override
  Future<List<Doctor>?> is_avialable(String username, String password) async {
    List<Doctor> doctors = [];
    try {
      await database
          .child("/Doctors")
          .orderByChild("/username")
          .equalTo(username)
          .once()
          .then((value) {
        var data = value.snapshot.value as Map<dynamic, dynamic>;
        data.forEach((key, value) {
          if (value["Password"] == password) {
            doctors.add(Doctor.fromJson(value, key));
          }
        });
      });

      if (doctors[0].username == username && doctors[0].password == password) {
        return doctors;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
