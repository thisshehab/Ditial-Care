class Bed {
  // ignore: non_constant_identifier_names
  // ignore: non_constant_identifier_names
  String? patient_name;
  // ignore: non_constant_identifier_names
  int? patient_age;
  // ignore: non_constant_identifier_names
  int? bp_max;
  // ignore: non_constant_identifier_names
  int? bp_min;
  // ignore: non_constant_identifier_names
  // ignore: non_constant_identifier_names
  String? nurse_id;
  // ignore: non_constant_identifier_names
  int? bed_number;
  // ignore: non_constant_identifier_names
  int? room_number;
  double? temp;
  int? spo2;
  int? hr;
  String? bed_Id;
  String? patient_Id;
  // ignore: non_constant_identifier_names
  bool? bed_state;
  Bed.normal(
      {required this.bed_Id,
      required this.patient_Id,
      required this.patient_name,
      required this.patient_age,
      required this.bp_max,
      required this.bp_min,
      required this.nurse_id,
      required this.bed_number,
      required this.room_number,
      required this.temp,
      required this.spo2,
      required this.hr,
      required this.bed_state});
  Bed();

  Bed.fromJson(Map<dynamic, dynamic> bed, nodeId) {
    bed_Id = nodeId;
    bed_number = bed['Number'];
    patient_Id = bed['P_Id'];
    bed_state = bed["B_state"];
    bp_max = bed['BP_Max'];
    hr = bed["HR"];
    nurse_id = bed['Nurse_Id'];
    patient_age = bed["Age"];
    spo2 = bed["SPO2"];
    patient_name = bed["Name"];
    room_number = bed["Room_Number"];
    temp = bed["Temp"];
    bp_min = bed["BP_Min"];
  }
  Map<dynamic, dynamic> toJson(Bed bed) {
    return {
      "Number": bed.bed_number,
      "B_state": bed.bed_state,
      "BP_Max": bed.bp_max,
      "HR": bed.hr,
      "Nurse_Id": bed.nurse_id,
      "P_Id": bed.patient_Id,
      "Age": bed.patient_age,
      "SPO2": bed.spo2,
      "Name": bed.patient_name,
      "Room_Number": bed.room_number,
      "Temp": bed.temp,
      "BP_Min": bed.bp_min
    };
  }
}
