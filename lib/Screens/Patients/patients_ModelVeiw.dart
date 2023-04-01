import 'package:get/get.dart';
import 'package:patient_observing/Models/bed_model.dart';
import 'package:patient_observing/Repositrys/bed_repository.dart';

class PatientController extends GetxController {
  final BedRepository repository;

  PatientController({required this.repository});
  Future<List<String>> getroomnumbers() async {
    return await repository.getallbeds();
  }

  Stream<List<Bed>> getpatients(String userId, int roomNumber) {
    return repository.get_all_patients_byRomm(roomNumber);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
