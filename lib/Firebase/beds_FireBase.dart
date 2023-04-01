// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:patient_observing/AppConstants/variables.dart';
import 'package:patient_observing/Models/bed_model.dart';
import 'package:patient_observing/Repositrys/bed_repository.dart';
import 'package:patient_observing/User_Information/userInfo.dart';
import 'package:intl/intl.dart';

class BedsFromFirebase extends BedRepository {
  var database = FirebaseDatabase.instance.ref();
  final bool local;

  BedsFromFirebase({required this.local}) {
    if (local) {
      database = FirebaseDatabase.instanceFor(
              app: Firebase.app(), databaseURL: Variables.firebase_local_url)
          .ref();
    }
  }
//! to make it without Stream>>>>>>>>>>>>
  // @override
  // List<Bed> get_nurse_patients(int userId, Function() update) {
  //   List<Bed> mydataList = [];
  //   FirebaseDatabase.instance.ref().child('/Bed').onValue.listen((event) {
  //     Map<dynamic, dynamic> values =
  //         event.snapshot.value as Map<dynamic, dynamic>;
  //     if (values != null) {
  //       values.forEach((key, value) {
  //         Map<String, dynamic> data = Map<String, dynamic>.from(value);
  //         // data['id'] = key; // Add the key as an 'id' field in the map
  //         // dataList.add(data);
  //         mydataList.add(Bed.fromJson(data, key));
  //         update();
  //       });
  //     }
  //     print(mydataList);
  //   });
  //   return mydataList;
  // }

  // getnoting() async {
  //   // Set up a Realtime Database listener to listen for changes to the "users" node
  //   FirebaseDatabase.instance
  //       .ref()
  //       .child('users')
  //       .onChildChanged
  //       .listen((event) async {
  //     final userId = event.snapshot.key;
  //     final userAge = event.snapshot.value['age'];

  //     // If user's age becomes exactly 20 years old, send a push notification using FCM
  //     if (userAge == 20) {
  //       final message = <String, String>{
  //         'notification': {
  //           'title': 'Age Warning',
  //           'body': 'Your age is now 20 years old!'
  //         },
  //         'token': 'USER_FCM_TOKEN'
  //       };
  //       await FirebaseMessaging.instance.sendMessage(
  //           to: "fGL1gOg5QTCdAPXR5u8W09:APA91bEFwM-bKBYpcdlsF9UqWqoErJ0CqyzohAKEWfS-tgP3-3Xrak6_5BVl3gbcrqb8Q3MYn93HXTdu2U3lSgHI_qAWAOYdzi-fmYfeKfLYGYZRx9Zk4vUFRZ8PnveaGRwyEWwbxGJR",
  //           data: {
  //             'body': 'Your age is now 20 years old!',
  //             'title': 'Age Warning',
  //           },
  //           ttl: 2);
  //     }
  //   });
  // }

  @override
  Stream<List<Bed>> get_nurse_patients(String userId) {
    Stream<DatabaseEvent> stream = database.child('/Bed').onValue;
    print("hi there its shehab");

    Stream<List<Bed>> streamtopublish = stream.map((event) {
      final bedmap = Map<dynamic, dynamic>.from(
          event.snapshot.value as Map<dynamic, dynamic>);
      List<Bed> bedlist = [];
      bedmap.entries.map((val) {
        // if (userId == val.value["Nurse_Id"]) {
        bedlist
            .add(Bed.fromJson(Map<String, dynamic>.from(val.value), val.key));
        // }
      }).toList();
      return bedlist;
    });
    return streamtopublish;
  }

  @override
  // ignore: avoid_renaming_method_parameters
  Stream<List<Bed>> get_doctor_patients(String doc_id) {
    Stream<DatabaseEvent> stream = database.child('/Bed').onValue;
    Stream<List<Bed>> streamtopublish = stream.map((event) {
      final bedmap = Map<dynamic, dynamic>.from(
          event.snapshot.value as Map<dynamic, dynamic>);
      List<Bed> bedlist = [];
      bedmap.entries.map((val) {
        // if (doc_id == val.value["Doc_Id"]) {
        bedlist
            .add(Bed.fromJson(Map<String, dynamic>.from(val.value), val.key));
        // }
      }).toList();
      return bedlist;
    });
    return streamtopublish;
  }

  @override
  Stream<List<Bed>> get_all_patients() {
    Stream<DatabaseEvent> stream = database
        .child('/Bed')
        .orderByChild("Nurse_Id")
        .equalTo(User.userId)
        .onValue;
    Stream<List<Bed>> streamtopublish = stream.map((event) {
      final bedmap = Map<dynamic, dynamic>.from(
          event.snapshot.value as Map<dynamic, dynamic>);
      final bedlist = bedmap.entries.map((val) {
        return Bed.fromJson(Map<String, dynamic>.from(val.value), val.key);
      }).toList();
      return bedlist;
    });
    return streamtopublish;
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Future<Map<String, String>> insert_patient(Bed patient, String bedId) async {
    try {
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('dd-MM-yy HH:mm').format(now);
      await database.child("/Bed").child(bedId).set(patient.toJson(patient));
      firestore.collection("Patients").doc("${patient.patient_Id}").set({
        "Name": patient.patient_name,
        "Age": patient.patient_age,
        "Nurse_Id": User.userId
      });
      firestore
          .collection("P_History")
          .doc("${patient.patient_Id}")
          .collection("Signs")
          .doc(formattedDate)
          .set({
        "Dangerous": false,
        "HR": patient.hr,
        "SPO2": patient.spo2,
        "Temp": patient.temp,
      });
      return {"status": "success"};
    } catch (e) {
      print(e);
      return {"status": "fail"};
    }
  }

  @override
  void update_patient(String nodeid) {}
  @override
  Stream<Bed> get_single_patient_as_stream(String bedId) {
    Stream<DatabaseEvent> stream = database.child('/Bed/$bedId').onValue;
    Stream<Bed> streamtopublish = stream.map((event) {
      final bedmap =
          Bed.fromJson(event.snapshot.value as Map<dynamic, dynamic>, bedId);
      return bedmap;
    });
    return streamtopublish;
  }

  @override
  void delete_patient(String bed_Id) async {
    return await database.child('/Bed/$bed_Id').remove();
  }

  @override
  Future<List<String>> getallbeds() async {
    return await database.child("/Bed").once().then((value) {
      List<String> beds = [];
      var data = value.snapshot.value as Map<dynamic, dynamic>;
      data.forEach((key, value) {
        if (!beds.contains(value["Room_Number"].toString())) {
          beds.add(value["Room_Number"].toString());
        }
      });
      return beds;
    });
  }

  @override
  Stream<List<Bed>> get_all_patients_byRomm(int roomNumber) {
    Stream<DatabaseEvent> stream = database
        .child('/Bed')
        .orderByChild("/Room_Number")
        .equalTo(roomNumber)
        .onValue;
    Stream<List<Bed>> streamtopublish = stream.map((event) {
      final bedmap = Map<dynamic, dynamic>.from(
          event.snapshot.value as Map<dynamic, dynamic>);
      final bedlist = bedmap.entries.map((val) {
        return Bed.fromJson(Map<String, dynamic>.from(val.value), val.key);
      }).toList();
      return bedlist;
    });
    return streamtopublish;
  }

  @override
  Future<Bed?> get_single_patient(String bedId) async {
    DatabaseReference reference =
        FirebaseDatabase.instance.ref().child("/Bed").child(bedId);
    DatabaseEvent dataSnapshot = await reference.once();
    if (dataSnapshot.snapshot.value != null) {
      return Bed.fromJson(
          Map<dynamic, dynamic>.from(
              dataSnapshot.snapshot.value as Map<dynamic, dynamic>),
          '');
    }
    return null;
  }

  FirebaseFirestore databasefirestore = FirebaseFirestore.instance;

  @override
  Future<Map<String, String>> update_patient_by_nurse(
      String nurseId, String bedId, String patientId) async {
    try {
      await database.child("/Bed/").child(bedId).update({"Nurse_Id": nurseId});
      var collection = databasefirestore.collection("Patients");
      await collection.doc(patientId).update({"Nurse_Id": nurseId});
      return {"status": "success"};
    } catch (e) {
      print(e);
      return {"status": "fail"};
    }
  }
}
