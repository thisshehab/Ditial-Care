class BasicPatientInfo {
  String? name;
  String? age;
  String? id;
  String? nurse_Id;

  BasicPatientInfo.normal(
      {required this.name,
      required this.age,
      required this.id,
      required this.nurse_Id});
  BasicPatientInfo();

  BasicPatientInfo.fromJson(Map<dynamic, dynamic> patient, String nodeId) {
    name = patient["Name"];
    age = patient["Age"].toString();
    nurse_Id = patient["Nurse_Id"];
    id = nodeId;
  }
  Map<String, dynamic> toJson(BasicPatientInfo patient) {
    return {"Age": patient.age, "Name": patient.name, "Nurse_Id": nurse_Id};
  }
}

class PatientSigns {
  int? id;
  double? temp;
  int? hr;
  int? spo2;
  String? time;
  bool? dangerous;

  PatientSigns.normal(
      {required this.id,
      required this.dangerous,
      required this.temp,
      required this.hr,
      required this.spo2,
      required this.time});
  PatientSigns();

  PatientSigns.fromJson(Map<dynamic, dynamic> patient, ttime) {
    id = patient["P_Id"];
    hr = patient["HR"];
    temp = patient["Temp"];
    spo2 = patient["SPO2"];
    dangerous = patient["Dangerous"];
    time = ttime;
  }
  Map<String, dynamic> toJson(PatientSigns patient) {
    return {
      "HR": patient.hr,
      "Temp": patient.temp,
      "SPO2": patient.spo2,
      "Dangerous": patient.dangerous
    };
  }
}
