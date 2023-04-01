class Doctor {
  int? id;
  String? name;
  String? username;
  String? password;
  String? nodeId;
  Doctor(
      {required this.id,
      required this.name,
      required this.username,
      required this.nodeId,
      required this.password});

  Doctor.fromJson(Map<dynamic, dynamic> doctor, String mynodeid) {
    id = doctor["Id"];
    name = doctor['Name'];
    username = doctor['username'];
    password = doctor['Password'];
    nodeId = mynodeid;
  }
  Map<dynamic, dynamic> toJson(Doctor doctor) {
    return {
      "Id": doctor.id,
      "Name": doctor.name,
      "username": doctor.username,
      "Password": doctor.password
    };
  }
}
