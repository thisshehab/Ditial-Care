class Nurse {
  int? id;
  String? name;
  String? username;
  String? password;
  String? nodeId;
  Nurse(
      {required this.id,
      required this.nodeId,
      required this.name,
      required this.username,
      required this.password});

  Nurse.fromJson(Map<dynamic, dynamic> nurse, String localnodeId) {
    id = nurse["Id"];
    nodeId = localnodeId;
    name = nurse['Name'];
    username = nurse['username'];
    password = nurse['Password'];
  }
  Map<dynamic, dynamic> toJson(Nurse nurse) {
    return {
      "Id": nurse.id,
      "Name": nurse.name,
      "username": nurse.username,
      "Password": nurse.password
    };
  }
}
