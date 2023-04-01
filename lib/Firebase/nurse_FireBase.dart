import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:patient_observing/Models/nurse_model.dart';

import '../AppConstants/variables.dart';
import '../Repositrys/nurse_repository.dart';

class NurseFromFirebase extends NurseRepository {
  var database = FirebaseDatabase.instance.ref();
  final bool local;

  NurseFromFirebase({required this.local}) {
    if (local) {
      database = FirebaseDatabase.instanceFor(
              app: Firebase.app(), databaseURL: Variables.firebase_local_url)
          .ref();
    }
  }
  @override
  Future<Map<String, String>> delete_Nurse(String docid) async {
    try {
      var mydata = await database.child("/Nurses/$docid").remove();
      return {"status": "success"};
    } catch (e) {
      return {"status": "fail"};
    }
  }
  @override
  Future<List<Nurse>> get_all_Nurses() async {
    return await database.child("/Nurses").once().then((value) {
      List<Nurse> nurse = [];
      var data = value.snapshot.value as Map<dynamic, dynamic>;
      data.forEach((key, value) {
        nurse.add(Nurse.fromJson(value, key));
      });
      return nurse;
    });
  }

  @override
  Future<Map<String, String>> insert_Nurse(Map data) async {
    //! note to change the name of the node>>>>>>>>>>>>>>>>>>>>>>>>>
    try {
      var mydata = await database.child("/Nurses").push();
      mydata.set(data);
      return {"status": "success"};
    } catch (e) {
      return {"status": "fail"};
    }
  }

  @override
  @override
  Future<Map<String, String>> update_Nurse(
      String docid, Map<String, String> data) async {
    try {
      await database.child("/Nurses/$docid").update(data);
      return {"status": "success"};
    } catch (e) {
      return {"status": "fail"};
    }
  }

  @override
  Future<List<Nurse>?> is_avialable(String username, String password) async {
    List<Nurse> nurse = [];
    try {
      await database
          .child("/Nurses")
          .orderByChild("/username")
          .equalTo(username)
          .once()
          .then((value) {
        var data = value.snapshot.value as Map<dynamic, dynamic>;
        data.forEach((key, value) {
          if (value["Password"] == password) {
            nurse.add(Nurse.fromJson(value, key));
          }
        });
      });

      if (nurse[0].username == username && nurse[0].password == password) {
        return nurse;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
