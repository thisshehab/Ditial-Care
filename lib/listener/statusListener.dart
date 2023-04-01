import 'dart:async';
import 'dart:io';

// import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:patient_observing/Firebase/patient_FireBase.dart';
import 'package:patient_observing/Other/Text_To_Speach.dart';
import 'package:patient_observing/Other/awsomenoti.dart';
import 'package:patient_observing/Repositrys/bed_repository.dart';
import 'package:patient_observing/Repositrys/patient_repository.dart';
import 'package:patient_observing/vital_signs.dart';
import 'package:intl/intl.dart';
import '../Models/bed_model.dart';
import '../Models/patient_model.dart';
import '../User_Information/userInfo.dart';

class PatientStatusListener {
  BedRepository data;
  PatientStatusListener({required this.data});
  // ignore: non_constant_identifier_names
  Map<String, Map<String, num>>? get_info_by_age(int age) {
    return Signs().getCategory(age);
  }

  bool call = false;
  void listen() {
    PatientRepository repository = Patients_FireBase();
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd-MM-yy HH:mm').format(now);
    data.get_nurse_patients(User.userId!).listen((event) {
      List<bool?> calls = event.map((value) => value.bed_state).toList();
      event.map((pateint) async {
        sendinpirod(pateint);
        // var sound = SoundPlayer();
        Map<String, Map<String, num>>? statusinfo =
            get_info_by_age(pateint.patient_age!);
        if (pateint.hr! < statusinfo!["HR"]!["normal min"]! ||
            pateint.hr! > statusinfo["HR"]!["normal max"]! ||
            pateint.temp! < statusinfo["Temp"]!["normal min"]! ||
            pateint.temp! > statusinfo["Temp"]!["normal max"]! ||
            pateint.spo2! < statusinfo["SPO2"]!["normal min"]! ||
            pateint.spo2! > statusinfo["SPO2"]!["normal max"]!) {
          await repository.insert_patient_signs(
              pateint.patient_Id!,
              PatientSigns.fromJson({
                "HR": pateint.hr,
                "Temp": pateint.temp,
                "SPO2": pateint.spo2,
                "Dangerous": true
              }, formattedDate));
          alaram(pateint);
        }
        if (pateint.bed_state == true) {
          print(
              "sdfadddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd");
          CustomNotification(
                  payload: {"data": pateint.bed_Id!},
                  id: int.parse(pateint.patient_Id!) + 3,
                  title:
                      " المريض ${pateint.patient_name} بحاجة إليك ${Emojis.hand_waving_hand} ${Emojis.hand_waving_hand}",
                  color: Color.fromARGB(255, 255, 235, 53),
                  body:
                      "الغرفة رقم ${pateint.room_number}السرير رقم ${pateint.bed_number}")
              .sendnoti();
        }
        if (calls.contains(true)) {
          playSoundLoop("sounds/fire.mp3");
        } else {
          stopsound();
        }
      }).toList();
    });
  }

  alaram(Bed pateint) {
    DateTime now = DateTime.now();

    CustomNotification(
            payload: {"data": pateint.bed_Id!},
            id: int.parse(pateint.patient_Id!) + 4,
            color: Color.fromARGB(255, 255, 19, 2),
            title: "حالة طارئة",
            body:
                "الغرفة رقم ${pateint.room_number} السرير رقم ${pateint.bed_number}    ${Emojis.symbols_name_badge} ${Emojis.symbols_name_badge} ${Emojis.symbols_name_badge} ${Emojis.symbols_name_badge}")
        .sendnoti();
        
    TTS(
            text:
                "حالة طارئة في الغرفة ${pateint.room_number} السرير ${pateint.bed_number}",
            repeattext: "",
            repeattext3: "")
        .speak();
  }

  AudioPlayer audioPlayer = AudioPlayer();
  AudioCache audioCache = AudioCache();
  Future<void> playSoundLoop(String path) async {
    audioCache.fixedPlayer = audioPlayer;
    await audioCache.play(
      path,
      stayAwake: true,
      // isNotification: true,
    );
  }

  Future<void> stopsound() async {
    audioCache.fixedPlayer = audioPlayer;
    try {
      await audioCache.fixedPlayer!.stop();
    } catch (e) {}
  }

// class SoundPlayer {
//   String path;
//   SoundPlayer(this.path, this.stoplop);
//   AudioPlayer audioPlayer = AudioPlayer();
//   late bool isLooping;
//   AudioCache audioCache = AudioCache();
//   bool stoplop;
// }
  sendinpirod(Bed pateint) {
    Timer.periodic(Duration(minutes: 1), (Timer t) async {
      Map<String, Map<String, num>>? statusinfo =
          get_info_by_age(pateint.patient_age!);
      PatientRepository repository = Patients_FireBase();
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('dd-MM-yy HH:mm').format(now);
      if (pateint.hr! < statusinfo!["HR"]!["normal min"]! ||
          pateint.hr! > statusinfo["HR"]!["normal max"]! ||
          pateint.temp! < statusinfo["Temp"]!["normal min"]! ||
          pateint.temp! > statusinfo["Temp"]!["normal max"]! ||
          pateint.spo2! < statusinfo["SPO2"]!["normal min"]! ||
          pateint.spo2! > statusinfo["SPO2"]!["normal max"]!) {
        await repository.insert_patient_signs(
            pateint.patient_Id!,
            PatientSigns.fromJson({
              "HR": pateint.hr,
              "Temp": pateint.temp,
              "SPO2": pateint.spo2,
              "Dangerous": true
            }, formattedDate));
      } else {
        await repository.insert_patient_signs(
            pateint.patient_Id!,
            PatientSigns.fromJson({
              "HR": pateint.hr,
              "Temp": pateint.temp,
              "SPO2": pateint.spo2,
              "Dangerous": false
            }, formattedDate));
      }
    });
  }
}
